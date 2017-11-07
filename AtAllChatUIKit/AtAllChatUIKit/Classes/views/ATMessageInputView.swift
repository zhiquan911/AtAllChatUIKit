//
//  ATMessageInputView.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/3.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit

/**
 *  工具条代理
 */
@objc public protocol ATMessageInputViewDelegate: AnyObject {
    
    /**
     *  松开手指完成录音
     */
    @objc optional func didFinishRecoingVoiceAction(voiceData: Data, voicePath: String, voiceDuration: Float)
    
    /**
     点击多媒体按钮
     
     - parameter inputView:
     - parameter sender:
     */
    @objc optional func didMediaButtonPress(inputView: ATMessageInputView)
    
    /**
     点击消息/语音切换按钮
     
     - parameter inputView:
     - parameter sender:
     */
    @objc optional func didMessageOrVoiceButtonPress(inputView: ATMessageInputView, isShowVoice: Bool)
}

public class ATMessageInputView: UIImageView, UITextViewDelegate {
    
    /**
     *  用于输入文本消息的输入框
     */
    public var inputTextView: ATMessageTextView!
    
    
    /**
     *  是否允许发送语音
     */
    public var allowsSendVoice: Bool = true // default is YES
    
    /**
     *  是否允许发送多媒体
     */
    public var allowsSendMultiMedia: Bool = true // default is YES
    
    /**
     *  是否支持发送表情
     */
    public var allowsSendFace: Bool = true // default is YES
    
    /**
     *  切换文本和语音的按钮
     */
    var voiceChangeButton: UIButton!
    
    /**
     *  +号按钮
     */
    var multiMediaSendButton: UIButton!
    
    /**
     *  第三方表情按钮
     */
    var faceSendButton: UIButton!
    
    /**
     *  语音录制按钮
     */
    var holdDownButton: UIButton!
    
    /**
     *  是否取消錄音
     */
    public var isCancelled: Bool? = false
    
    /**
     *  是否正在錄音
     */
    public var isRecording: Bool? = false
    
    /**
     *  获取输入框内容字体行高
     *
     */
    var textViewLineHeight: Float = 36.0
    
    /**
     *  录音工具
     */
    var voiceRecord: VoiceRecord!
    
    /// 显示录音状态
    var recordingHUD: ATProgressHUD!
    
    weak var delegate: ATMessageInputViewDelegate?
    /**
     *  获取最大行数
     *
     *  @return 返回最大行数
     */
    var maxLines: Float {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            return 3.0
        } else {
            return 8.0
        }
    }
    
    //文本输入框的高度约束，用于动态调整高度
    var inputTextHeightConstraints: NSLayoutConstraint!
    var currentTextHeight: Float = 36.0
    
    /**
     *  获取根据最大行数和每行高度计算出来的最大显示高度
     *
     *  @return 返回最大显示高度
     */
    var maxHeight: Float {
        return (self.maxLines + 1.0) * self.textViewLineHeight;
    }
    
    
    
    // MARK:初始化方法
    
    /**
     配置UI的初始化值
     */
    func setupUI() {
        
        // 默认设置
        self.isUserInteractionEnabled = true
        self.allowsSendVoice = true
        self.allowsSendFace = true
        self.allowsSendMultiMedia = true
        
        //创建输入框
        var textView: ATMessageTextView
        textView = ATMessageTextView();
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.returnKeyType = UIReturnKeyType.send;
        textView.enablesReturnKeyAutomatically = true; // UITextView内部判断send按钮是否可以用
        textView.placeHolder = NSLocalizedString("发送新消息", comment: "");
        textView.delegate = self;
        
        self.addSubview(textView)
        self.inputTextView = textView
        self.inputTextView.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).cgColor
        self.inputTextView.layer.borderWidth = 0.65;
        self.inputTextView.layer.cornerRadius = 6.0;
    }
    
    // 配置工具栏组件
    func setupMessageInputViewBar() {
        // 配置输入工具条的样式和布局
        // 水平间隔
        let horizontalPadding: Float = 6.0
        
        // 垂直间隔
        let verticalPadding: Float = 5.0
        
        // 输入框
        let textViewLeftMargin: Float = 6.0
        
        var testFieldMarginFront: Float = 0.0
        
        var testFieldMarginBehind: Float = 0.0
        
        // 按钮对象消息
        var button: UIButton;
        
        // 允许发送语音
        if (self.allowsSendVoice) {
            
            button = self.createButtonWithImage(image: UIImage(named: "voice"), hlImage: UIImage(named: "voice_HL"))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(toggleMessageOrVoiceButton), for: UIControlEvents.touchUpInside)
            button.setBackgroundImage(UIImage(named: "keyboard"), for: UIControlState.selected)
            self.voiceChangeButton = button
            self.addSubview(button)
            
            //水平布局
            self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|-\(horizontalPadding)-[voiceChangeButton(\(self.textViewLineHeight))]",
                    options: NSLayoutFormatOptions(),
                    metrics: nil,
                    views:["voiceChangeButton": self.voiceChangeButton]))
            
            //垂直布局
            self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|-\(verticalPadding)-[voiceChangeButton(\(self.textViewLineHeight))]",
                    options: NSLayoutFormatOptions(),
                    metrics: nil,
                    views:["voiceChangeButton": self.voiceChangeButton]))
            
            testFieldMarginFront = horizontalPadding + self.textViewLineHeight
        }
        
        // 允许发送多媒体消息，为什么不是先放表情按钮呢？因为布局的需要！
        if (self.allowsSendMultiMedia) {
            button = self.createButtonWithImage(image: UIImage(named: "multiMedia"), hlImage: UIImage(named: "multiMedia_HL"))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(handleMediaButtonPress), for: UIControlEvents.touchUpInside)
            button.tag = 2
            self.multiMediaSendButton = button
            self.addSubview(button)
            
            //水平布局
            self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:[multiMediaSendButton(\(self.textViewLineHeight))]-\(horizontalPadding)-|",
                    options: NSLayoutFormatOptions(),
                    metrics: nil,
                    views:["multiMediaSendButton": self.multiMediaSendButton]))
            
            //垂直布局
            self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|-\(verticalPadding)-[multiMediaSendButton(\(self.textViewLineHeight))]",
                    options: NSLayoutFormatOptions(),
                    metrics: nil,
                    views:["multiMediaSendButton": self.multiMediaSendButton]))
            
            testFieldMarginBehind = self.textViewLineHeight + horizontalPadding
        }
        
        
        //输入框的高度约束
        self.inputTextHeightConstraints = NSLayoutConstraint(
            item: self.inputTextView,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: CGFloat(self.textViewLineHeight))
        
        self.inputTextView.addConstraint(self.inputTextHeightConstraints)
        
        //垂直布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-\(verticalPadding)-[inputTextView]-\(verticalPadding)-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["inputTextView": self.inputTextView]))
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-\(testFieldMarginFront + textViewLeftMargin)-[inputTextView]-\(testFieldMarginBehind + textViewLeftMargin)-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["inputTextView": self.inputTextView]))
        
        //背景颜色
        self.backgroundColor = UIColor.white;
        self.image = UIImage(named: "input-bar-flat")?.resizableImage(withCapInsets: UIEdgeInsetsMake(2.0, 0.0, 0.0, 0.0),
                                                                      resizingMode: UIImageResizingMode.tile)
        
        
        // 如果是可以发送语言的，那就需要一个按钮录音的按钮，事件可以在外部添加
        if (self.allowsSendVoice) {
            
            let edgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
            button = self.createButtonWithImage(
                image: UIImage(named: "VoiceBtn_black")?.resizableImage(withCapInsets: edgeInsets, resizingMode: UIImageResizingMode.stretch), hlImage: UIImage(named: "VoiceBtn_blackHL")?.resizableImage(withCapInsets: edgeInsets, resizingMode: UIImageResizingMode.stretch))
            button.setTitleColor(
                UIColor.darkGray,
                for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            button.setTitle(NSLocalizedString("按住 说话", comment: ""), for: .normal)
            button.setTitle(NSLocalizedString("松开 结束", comment: ""), for: .highlighted)
            button.isHidden = !self.voiceChangeButton.isSelected;
            
            //添加触发事件
            button.addTarget(self, action: #selector(beginRecordVoice), for: UIControlEvents.touchDown)
            button.addTarget(self, action: #selector(endRecordVoice), for: UIControlEvents.touchUpInside)
            button.addTarget(self, action: #selector(cancelRecordVoice), for: [UIControlEvents.touchUpOutside, UIControlEvents.touchCancel])
            button.addTarget(self, action: #selector(remindDragExit), for: UIControlEvents.touchDragExit)
            button.addTarget(self, action: #selector(remindDragEnter), for: UIControlEvents.touchDragEnter)
            
            self.holdDownButton = button
            self.addSubview(button)
            self.holdDownButton.translatesAutoresizingMaskIntoConstraints = false
            
            //垂直布局
            self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[holdDownButton]|",
                    options: NSLayoutFormatOptions(),
                    metrics: nil,
                    views:["holdDownButton": self.holdDownButton]))
            
            self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|-\(testFieldMarginFront + textViewLeftMargin)-[holdDownButton]-\(testFieldMarginBehind + textViewLeftMargin)-|",
                    options: NSLayoutFormatOptions(),
                    metrics: nil,
                    views:[
                        "holdDownButton": self.holdDownButton]))
        }
        
        self.recordingHUD = ATProgressHUD(frame: CGRect(x: 0, y: 0, width: 140, height: 140))
        
        //初始化录音工具，并设定音量改变时的处理
        self.voiceRecord = VoiceRecord(minRecordTime: 1.0, powerForChannel: {
            [unowned self](lowPassResults) -> Void in
            //调整音量的图片显示
            self.recordingHUD.configRecordingHUDImageWithPeakPower(peakPower: CGFloat(lowPassResults))
        })
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            self.setupMessageInputViewBar()
        }
    }
    
    //MARK：私有方法
    
    /**
     设置按钮图片
     
     - parameter image:
     - parameter hlImage:
     
     - returns:
     */
    private func createButtonWithImage(image: UIImage?, hlImage: UIImage?) -> UIButton {
        let button = UIButton()
        if let mImage = image {
            button.setBackgroundImage(mImage, for: UIControlState.normal)
        }
        
        if let mImage = hlImage {
            button.setBackgroundImage(mImage, for: UIControlState.highlighted)
        }
        
        return button
    }
    
    //MARK:按钮控制方法
    
    /**
     文本或语音切换按钮
     */
    @objc func toggleMessageOrVoiceButton() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.voiceChangeButton.isSelected = !self.voiceChangeButton.isSelected
            self.holdDownButton.isHidden = !self.voiceChangeButton.isSelected
            self.inputTextView.isHidden = self.voiceChangeButton.isSelected
            
            if self.voiceChangeButton.isSelected {
                self.inputTextHeightConstraints.constant = CGFloat(self.textViewLineHeight);
                //收回键盘
                self.inputTextView.resignFirstResponder()
                
            } else {
                self.inputTextHeightConstraints.constant = CGFloat(self.currentTextHeight)
                //弹出键盘
                self.inputTextView.becomeFirstResponder()
            }
            self.delegate?.didMessageOrVoiceButtonPress?(
                inputView: self, isShowVoice:
                self.voiceChangeButton.isSelected)
            self.layoutIfNeeded()
        })
        
    }
    
    //切换为文字模式
    func changeKeyboardMode() {
        self.voiceChangeButton.isSelected = false
        self.holdDownButton.isHidden = true
        self.inputTextView.isHidden = false
        self.inputTextHeightConstraints.constant = CGFloat(self.currentTextHeight)
        self.layoutIfNeeded()
    }
    
    /**
     点击多媒体按钮
     */
    @objc func handleMediaButtonPress() {
        self.delegate?.didMediaButtonPress?(inputView: self)
    }
    
    //闭包函数测试
    func printMessage(sender:() -> Void) {
        sender()
        print("printMessage")
    }
    
    
    
}

// MARK: - 录音相关方法
extension ATMessageInputView {
    
    /**
     按下开始录音
     */
    @objc func beginRecordVoice() {
        self.isCancelled = false;
        self.isRecording = false;
        self.recordingHUD.startReocordingHUD(view: self.superview!)
        self.voiceRecord.startRecord {
            [unowned self]() -> Void in
            self.isRecording = true
        }
    }
    
    /**
     手指松开停止录音
     */
    @objc func endRecordVoice() {
        self.voiceRecord.stopRecord {
            [unowned self](isRecordSuccess, voiceData, voicePath, voiceDuration) -> Void in
            self.isRecording = false
            
            //如果记录成功
            if isRecordSuccess {
                //成功回调
                self.recordingHUD.stopRecordingHUD()
                if (voiceData != nil) {
                    //发送语音数据
                    self.delegate?.didFinishRecoingVoiceAction?(voiceData: voiceData!, voicePath: voicePath, voiceDuration: voiceDuration)
                }
                
            } else {
                //失败回调
                self.recordingHUD.showMessageTooShortTip()
            }
        }
    }
    
    /**
     取消录音
     */
    @objc func cancelRecordVoice() {
        if self.isRecording! {
            self.recordingHUD.cancelRecordingHUD()
            self.voiceRecord.cancelRecord(completion: {
                [unowned self]() -> Void in
                self.isRecording = false
            })
        } else {
            self.isCancelled = true
        }
    }
    
    /**
     手指移出按钮
     */
    @objc func remindDragExit() {
        //暂停录音，只是显示效果，其实还在录音
        self.recordingHUD.pauseRecordingHUD()
    }
    
    /**
     手指再次移进按钮
     */
    @objc func remindDragEnter() {
        //继续显示录音
        self.recordingHUD.resumeRecordingHUD()
    }
    
}
