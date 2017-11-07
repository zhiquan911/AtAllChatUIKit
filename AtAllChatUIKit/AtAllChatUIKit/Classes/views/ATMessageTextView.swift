//
//  ATMessageTextView.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/3.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit

public class ATMessageTextView: UITextView {
    
    /**
     *  提示用户输入的标语
     */
    public var placeHolder: String = "" {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /**
     *  标语文本的颜色
     */
    public var placeHolderColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsDisplay()
        }
        
    }
    
    /**
     *  获取自身文本占据有多少行
     *
     *  @return 返回行数
     */
    public var numberOfLinesOfText: Int {
        return ATMessageTextView.numberOfLinesForMessage(text: self.text);
    }
    
    /**
     *  获取每行的高度
     *
     *  @return 根据iPhone或者iPad来获取每行字体的高度
     */
    public class var maxCharactersPerLine: Int {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 33:109
    }
    
    /**
     *  获取某个文本占据自身适应宽带的行数
     *
     *  @param text 目标文本
     *
     *  @return 返回占据行数
     */
    public class func numberOfLinesForMessage(text: String) -> Int {
        
        return (text.count / ATMessageTextView.maxCharactersPerLine) + 1;
    }
    
    
    // mark - Notifications
    
    @objc func didReceiveTextDidChangeNotification(notification: NSNotification) {
        self.setNeedsDisplay()
    }
    
    func setupUI() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveTextDidChangeNotification(notification:)),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: self)
        
        placeHolderColor = UIColor.lightGray
        self.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0, 0.0, 10.0, 8.0)
        self.contentInset = UIEdgeInsets.zero;
        self.isScrollEnabled = true;
        self.scrollsToTop = false;
        self.isUserInteractionEnabled = true;
        self.font = UIFont.systemFont(ofSize: 16);
        self.textColor = UIColor.black;
        self.backgroundColor = UIColor.white;
        self.keyboardAppearance = UIKeyboardAppearance.default;
        self.keyboardType = UIKeyboardType.default;
        self.returnKeyType = UIReturnKeyType.default;
        self.textAlignment = NSTextAlignment.left;
    }
    
    
    override public func awakeFromNib() {
        self.setupUI()
    }
    
    init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if (self.textStorage.length == 0) && self.placeHolder != "" {
            
            let placeHolderRect: CGRect = CGRect(x: 10.0, y: 7.0, width: rect.size.width, height: rect.size.height)
            
            self.placeHolderColor.set()
            
            let paragraphStyle = NSMutableParagraphStyle();
            paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail;
            paragraphStyle.alignment = self.textAlignment;
            
            let textFontAttributes = [
                NSAttributedStringKey.font: self.font!,
                NSAttributedStringKey.foregroundColor: self.placeHolderColor,
                NSAttributedStringKey.paragraphStyle: paragraphStyle
                ] as [NSAttributedStringKey : Any]
            
            NSString(string: self.placeHolder).draw(
                in: placeHolderRect,
                withAttributes: textFontAttributes)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    
}
