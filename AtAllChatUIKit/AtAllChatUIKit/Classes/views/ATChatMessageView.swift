//
//  ATChatMessageView.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/3.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit
import IGListKit
import AsyncDisplayKit

open class ATChatMessageView: UIView {
    
    //常量
    let kShareMenuViewHeight: CGFloat = 216.0
    
    //加载更多分区出的标记
    let spinToken = "spinner"
    
    /// 消息表格
//    public var tableView: ATChatTableView!
    public var tableView: ASCollectionNode!
    
    /// 文本输入框
    public var messageInputView: ATMessageInputView!
    
    /// 多功能菜单
    public var shareMenuView: ATShareMenuView!
    
    /// 组件所在控制器
    @IBOutlet public var viewController: UIViewController?
    
    /// 消息数组
    public var messages = [ATMessageItem]()
    
    /// 消息发送者，当天控制聊天的用户唯一键值
    public var userkey: String = ""
    
    /// 消息发送者昵称
    public var username: String = ""
    
    /// 当用户滚动视图时是否不滚动到底部
    public var shouldPreventScrollToBottomWhileUserScrolling: Bool = false
    
    /// 加载更多消息loading
    public var progressViewLoadMore: UIActivityIndicatorView!
    
    /// 是否允许可以发送语音
    public var allowsSendVoice: Bool = true
    
    /// 是否允许发送多媒体
    public var allowsSendMultiMedia: Bool = true
    
    /// 组件代理
    @IBOutlet weak public var delegate: ATChatMessageViewDelegate?
    
    @IBOutlet weak public var shareMenuViewDelegate: ATShareMenuViewDelegate? {
        didSet {
            if self.shareMenuView != nil {
                self.shareMenuView.delegate = self.shareMenuViewDelegate
            }
        }
    }
    
    /// 多功能菜单是否显示
    var isShareMenuViewShow = false
    
    /// 发送消息输入框的底部约束，用于控制弹出键盘的相对位置动画变化
    var messageInputBottomConstraints: NSLayoutConstraint!
    
    /// 是否加载更多消息
    var _shouldLoadMoreMessagesScrollToTop: Bool = true
    
    /// 是否滑动
    var isDragging: Bool = false
    
    var currentScrollViewContentOffset: CGPoint = CGPoint.zero
    //    var oldScrollViewContentSize: CGSize = CGSize.zero
    //    var currentSelecedCell: SCMessageTableViewCell?
    //    var imagePicker: UIImagePickerController!
    
    
    //多媒体工具条的底部约束，用于动态调整高度
    var shareMenuViewBottomConstraints: NSLayoutConstraint!
    
    /// 是否加载更多数据
    public var loadingMoreData: Bool = false
    
    public var canLoadmore: Bool = true
    
    
    /// 是否滚动到表格底部
    var isTableScrollToBottom: Bool {
        NSLog("self.tableView.contentOffset.y = \(self.tableView.contentOffset.y)")
        if self.tableView.contentOffset.y <= 0 {
            return true
        } else {
            return false
        }
    }
    
    /// 列表适配器
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController, workingRangeSize: 2)
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
}


// MARK: - 内部方法
public extension ATChatMessageView {
    
    /// 配置UI
    func setupUI() {
        
        //UIControlEventTouchDown 此事件是手指碰到按钮就调用了。 这样在IOS7上会有一个冲突。
        //IOS7以后增加了手势滑动返回。 在手势滑动返回的那个区域是不允许
        //有UIControlEventTouchDown事件的。 不然的话，就会有事件冲突了。
        //系统不知道是要准备返回 还是要点那个BUTTON。 。
        self.viewController?
            .navigationController?
            .interactivePopGestureRecognizer?
            .delaysTouchesBegan = false
        
        
        //设置建议的行高度
        let layout = UICollectionViewFlowLayout()
        self.tableView = ASCollectionNode(frame: .zero, collectionViewLayout: layout)
        self.tableView.inverted = true
        self.tableView.view.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor(hex: 0xeaebec)
        self.tableView.view.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        self.addSubnode(self.tableView)
        
        //配置列表适配器
//        self.adapter.collectionView = self.tableView
        self.adapter.setASDKCollectionNode(self.tableView)
        self.adapter.dataSource = self
        self.adapter.scrollViewDelegate = self

        //文本输入工具栏
        self.messageInputView = ATMessageInputView(frame: CGRect.zero)
        self.messageInputView.allowsSendVoice = self.allowsSendVoice
        self.messageInputView.allowsSendMultiMedia = self.allowsSendMultiMedia
        self.messageInputView.translatesAutoresizingMaskIntoConstraints = false
        self.messageInputView.inputTextView.delegate = self
        self.messageInputView.delegate = self
        self.addSubview(messageInputView)
        
        
        //多媒体工具栏
        self.shareMenuView = ATShareMenuView()
        self.shareMenuView.delegate = self.shareMenuViewDelegate
        self.shareMenuView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.shareMenuView)
        
        //约束布局
        self.setupViewConstraints();
        
    }
    
    /**
     配置视图组件约束
     */
    func setupViewConstraints() {
        
        let views: [String: Any] = [
            "tableView": self.tableView.view,
            "messageInputView": self.messageInputView,
            "shareMenuView": self.shareMenuView
        ]
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[tableView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views:views));
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tableView]-0-[messageInputView]",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views:views))
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[messageInputView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views:views))
        
        //输入框的高度约束
        self.messageInputBottomConstraints = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.messageInputView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 0)
        
        self.addConstraint(self.messageInputBottomConstraints)
        
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[shareMenuView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views:views))
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[messageInputView]-0-[shareMenuView(\(kShareMenuViewHeight))]",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views:views))
        
    }
    
    
    /// 添加通知监听方法
    func addNotification() {
        
        // KVO 检查contentSize
        self.messageInputView.inputTextView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        
        //键盘弹出时的监听，注意通过selector调用的方法不能为私有方法
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardChange),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardChange),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
        
        //注册通知，当键盘弹出时把表格混会到底部
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.tableViewScrollToBottom),
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil)
        
    }
    
    /// 移除通知监听方法
    func removeNotification() {
        //注销通知
        NotificationCenter.default.removeObserver(self)
        
        // remove KVO
        self.messageInputView.inputTextView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    /// 键盘布局改变
    ///
    /// - Parameter notification:
    @objc func keyboardChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyBoardInfo = userInfo[UIKeyboardFrameEndUserInfoKey] else {
            return
        }
        let keyBoardHeight = (keyBoardInfo as AnyObject).cgRectValue.size.height //键盘最终的高度
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        [unowned self]() -> Void in
                        
                        //adjust ChatTableView's height
                        if (notification.name == NSNotification.Name.UIKeyboardWillShow) {
                            self.isShareMenuViewShow = false    //键盘弹出后，多媒体隐藏
                            if keyBoardHeight > 0 {
                                self.messageInputBottomConstraints.constant = keyBoardHeight
                            }
                        } else {
                            
                            if !self.isShareMenuViewShow {
                                //如果用户不是显示多媒体菜单，才把键盘高度设为0
                                self.messageInputBottomConstraints.constant = 0
                            }
                            
                        }
                        
                        self.layoutIfNeeded()
                        
        }) { (Bool) -> Void in
            
        }
        
    }
    
    /**
     切换多媒体view的可见
     
     - parameter isVisible: 有值时，把这个值设置是否显示
     */
    func toggleMediaViewVisible(isVisible: Bool? = nil) {
        if (isVisible != nil) {
            self.isShareMenuViewShow = isVisible!
        } else {
            self.isShareMenuViewShow = !self.isShareMenuViewShow
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            [unowned self]() -> Void in
            if self.isShareMenuViewShow {
                self.messageInputView.inputTextView.resignFirstResponder()
                self.messageInputBottomConstraints.constant = self.kShareMenuViewHeight
            } else {
                self.messageInputBottomConstraints.constant = 0
            }
            self.layoutIfNeeded()
            })
        {
            [unowned self](isSuccess) -> Void in
            if self.isShareMenuViewShow {
                self.tableViewScrollToBottomAnimated(true)
            }
            
        }
    }
    
    /**
     动态调整textView高度
     
     - parameter textView:
     */
    func layoutAndAnimateMessageInputTextView(textView: UITextView) {
        let maxHeight = self.messageInputView.maxHeight;
        var contentH = Float(textView.sizeThatFits(textView.frame.size).height)
        contentH = ceilf(contentH)
        if contentH <= maxHeight {
            UIView.animate(withDuration: 0.25,
                                       animations: { () -> Void in
                                        //改变输入框的高度约束
                                        self.messageInputView.inputTextHeightConstraints.constant = CGFloat(contentH)
                                        self.messageInputView.layoutIfNeeded()
            }) { (Bool) -> Void in
                self.messageInputView.currentTextHeight = contentH
            }
        }
        
    }
    
}


// MARK: - 公开方法
public extension ATChatMessageView {
    
    
    /// 视图再现
    public func viewDidAppear() {
        
        self.messageInputView.inputTextView.isEditable = true
        
        //刷新多媒体菜单
        self.shareMenuView.reloadData()
        
        self.addNotification()
    }
    
    
    /// 视图消息
    public func viewDidDisappear() {
        
        self.messageInputView.inputTextView.isEditable = false
        
        self.removeNotification()
        
    }
    
    
    /// 滚动表格到底部
    @objc public func tableViewScrollToBottom() {
        self.tableViewScrollToBottomAnimated(true)
    }
    
    
    /// 把表格滚回到底部
    ///
    /// - Parameter animated: 是否显示动画
    public func tableViewScrollToBottomAnimated(_ animated: Bool) {
//        self.tableView.loadMoreOnTop = false
        if !isTableScrollToBottom {
            if self.messages.count == 0 {
                return
            }
            
            //滚动到底部
            self.adapter.scroll(to: self.messages.first!, supplementaryKinds: nil, scrollDirection: .vertical, scrollPosition: .top, animated: animated)

        }
    }
    
    /**
     增加聊天消息到表格
     
     - parameter chatMessages:     消息数组
     - parameter toPosition:            添加在哪个位置
     - parameter isScrollToBottom: 是否滚动到底部
     */
    public func add(
        chatMessages: [ATMessageItem],
        toBottomPosition: Bool = true,
        isScrollToBottom: Bool = true,
        animated: Bool = false) {
        if toBottomPosition {
            self.messages = chatMessages + self.messages
        } else {
            self.messages = self.messages + chatMessages
        }

        self.adapter.performUpdates(animated: animated) {
            (flag) in
            self.loadingMoreData = false
            if isScrollToBottom {
                self.tableViewScrollToBottomAnimated(animated)
            }
        }
        
    }
    
    
    /// 重新加载数据
    ///
    /// - Parameters:
    ///   - messages: 消息数组
    ///   - isScrollToBottom: 是否滚动到底部
    ///   - animated: 是否动画
    public func reloadData(messages: [ATMessageItem], isScrollToBottom: Bool = true, animated: Bool = false) {
        self.messages.removeAll()
        self.messages = messages
        self.adapter.performUpdates(animated: animated)
    }
    
    
    /// 更新数据
    ///
    /// - Parameter animated:
    public func performUpdates(animated: Bool = true) {
        
        self.adapter.performUpdates(animated: animated)
    }
    
    
    /// 重新加载消息项
    ///
    /// - Parameter messages:
    public func reloadMessages(_ messages: [ATMessageItem]) {
        for msg in messages {
            self.reloadMessage(msg)
        }
    }
    
    
    /// 刷新单个消息的UI
    ///
    /// - Parameter message:
    public func reloadMessage(_ message: ATMessageItem) {
        
        let section = self.adapter.section(for: message)
        guard section != NSNotFound else {
            return
        }
        guard let cellNode = self.tableView.nodeForItem(at: IndexPath(item: 0, section: section)) as? ATMessageCellProtocal else {
            return
        }
        //刷新显示状态
        cellNode.updateMessageStatus(message)
    }

    
    /**
     完成发送消息
     */
    public func finishSendMessage() {
        
        self.messageInputView.inputTextView.text = ""
        self.messageInputView.inputTextView.enablesReturnKeyAutomatically = false
        
        //把发送按钮变灰
        DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.messageInputView.inputTextView.enablesReturnKeyAutomatically = true
            self.messageInputView.inputTextView.reloadInputViews()
        }
        
        
    }
}


// MARK: - 实现表格代理方法
extension ATChatMessageView: ListAdapterDataSource {
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects = self.messages as [ListDiffable]
        
        // 下拉加载更多时，把加载更多的单元格样式添加到列表头
        if self.loadingMoreData {
            objects.append(self.spinToken as ListDiffable)
        }
        
        return objects
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        //如果行元素为加载更多标识，显示加载更多分区样式
        if let obj = object as? String, obj == self.spinToken {
            return SpinnerSectionController()
        } else {
            let obj = object as! ATMessageItem
            let preMessage = self.messages.Object(after: obj)
            return ATMessageTextSection(preMessage: preMessage)
        }
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}


// MARK: - 实现输入工具栏的委托方法
extension ATChatMessageView: ATMessageInputViewDelegate {
    
    public func didMediaButtonPress(inputView: ATMessageInputView) {
        self.toggleMediaViewVisible()
        if self.messageInputView.voiceChangeButton != nil
            && self.messageInputView.voiceChangeButton.isSelected {
            self.messageInputView.changeKeyboardMode()
        }
    }
    
    public func didFinishRecoingVoiceAction(voiceData: Data, voicePath: String, voiceDuration: Float) {
        
    }
    
    public func didMessageOrVoiceButtonPress(inputView: ATMessageInputView, isShowVoice: Bool) {
        if isShowVoice && self.isShareMenuViewShow {
            self.messageInputBottomConstraints.constant = 0
            self.isShareMenuViewShow = false
        }
    }
}

//MARK: textView委托方法
extension ATChatMessageView: UITextViewDelegate{
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            if !textView.text.isEmpty {
                
                let message = ATMessageItem()
                let timestamp = Date().timeIntervalSince1970
                message.messageId = self.userkey + timestamp.toString()
                message.senderId = self.userkey
                message.senderName = self.username
                message.sended = false;
                message.messageMediaType = .text
                message.text = textView.text;
                message.messageSourceType = .send;
                message.timestamp = Int64(timestamp)
                
                //委托发送消息处理
                self.delegate?.chatView?(view: self, didSendMessage: [message])
                
                //添加消息到表格最底
                self.add(chatMessages: [message],
                         toBottomPosition: true,
                         isScrollToBottom: false,
                         animated: true)
                
                //完成发送
                self.finishSendMessage()
                
                return false
            } else {
                return false
            }
            
        }
        
        return true;
    }
    
}

extension ATChatMessageView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distance = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.height)
        if distance > 0 && distance <= 44 && scrollView.contentSize.height > 0 {
            if !loadingMoreData && self.canLoadmore {
                self.loadingMoreData = true
//                NSLog("distance = \(distance)")
                self.adapter.performUpdates(animated: false, completion: nil)
                
                let shouldLoad = self.delegate?.shouldLoadMoreMessagesScrollToTop?(view: self) ?? true
                if shouldLoad {
//                    NSLog("self.loadingMoreData = \(self.loadingMoreData)")
                    self.delegate?.loadMoreMessagesScrollTotop?(view: self)
                }
            }
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.loadingMoreData {
            return
        }
        self.isDragging = true
        if self.isShareMenuViewShow {
            self.toggleMediaViewVisible(isVisible: false)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isDragging = false
    }

}

// MARK: - Key-value Observing
extension ATChatMessageView {
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is ATMessageTextView {
            if keyPath == "contentSize" { //观测到contentSize变化就调用调整textView高度
                self.layoutAndAnimateMessageInputTextView(textView: object as! UITextView)
            }
        }
    }
}



