//
//  ATChatMessageView.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/3.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit
import IGListKit

open class ATChatMessageView: UIView {
    
    //常量
    let kShareMenuViewHeight: CGFloat = 216.0
    
    /// 消息表格
    public var tableView: ATChatTableView!
    
    /// 文本输入框
    public var messageInputView: ATMessageInputView!
    
    /// 多功能菜单
    public var shareMenuView: ATShareMenuView!
    
    /// 组件所在控制器
    public var viewController: UIViewController?
    
    /// 多功能菜单是否显示
    var isShareMenuViewShow = false
    
    //    var button: UIButton!
    
    /// 消息数组
    public var messages = [ATMessageItem]()
    
    var messageSender: String = ""
    
    /// 发送消息输入框的底部约束，用于控制弹出键盘的相对位置动画变化
    var messageInputBottomConstraints: NSLayoutConstraint!
    
    
    /// 是否加载更多消息
    var _shouldLoadMoreMessagesScrollToTop: Bool? = true
    
    /// 加载更多消息loading
    public var progressViewLoadMore: UIActivityIndicatorView!
    
    /// 表格头部
    public var headerView: UIView!
    var isDragging: Bool! = false
    var currentScrollViewContentOffset: CGPoint = CGPoint.zero
    //    var oldScrollViewContentSize: CGSize = CGSize.zero
    //    var currentSelecedCell: SCMessageTableViewCell?
    //    var imagePicker: UIImagePickerController!
    
    
    //多媒体工具条的底部约束，用于动态调整高度
    var shareMenuViewBottomConstraints: NSLayoutConstraint!
    
    /// 是否允许可以发送语音
    var allowsSendVoice: Bool = true
    
    /// 是否允许发送多媒体
    var allowsSendMultiMedia: Bool = true
    
    /// 是否加载更多数据
    var loadingMoreData: Bool = false {
        didSet {
//            if loadingMoreData {
//                self.progressViewLoadMore.isHidden = false
//                self.progressViewLoadMore.startAnimating()
//            } else {
//                self.progressViewLoadMore.stopAnimating()
//                self.progressViewLoadMore.isHidden = true
//            }
        }
    }
    
    var canLoadmore: Bool = false
    //    {
    //        set {
    //            if newValue {
    //                self.tableView.tableHeaderView = self.headerView
    //            } else {
    //                self.tableView.tableHeaderView = nil
    //            }
    //        }
    //        get {
    //            if self.tableView.tableHeaderView == nil {
    //                return false
    //            } else {
    //                return true
    //            }
    //        }
    //    }
    
    /// 是否滚动到表格底部
    var isTableScrollToBottom: Bool {
        let height = tableView.frame.size.height
        let contentYoffset = tableView.contentOffset.y
        let distanceFromBottom = tableView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            return true
        } else {
            return false
        }
    }
    
    /// 列表适配器
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController)
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
        
        
        //        self.delegate = self
        //设置建议的行高度
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: self.bounds.width, height: ATChatMessageViewCell.cellHeight)
        self.tableView = ATChatTableView(frame: .zero, collectionViewLayout: layout)
        self.adapter.collectionView = self.tableView
        self.adapter.dataSource = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.white
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        self.addSubview(self.tableView)
        
        
        //加入loading表头
        //        self.headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        //        self.headerView.backgroundColor = self.tableView.backgroundColor
        //        self.tableView.tableHeaderView = headerView
        
        //加入loadingView
//        self.progressViewLoadMore = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
//        self.progressViewLoadMore.translatesAutoresizingMaskIntoConstraints = false
//        self.headerView.addSubview(self.progressViewLoadMore)
        
        
        self.messageInputView = ATMessageInputView(frame: CGRect.zero)
        self.messageInputView.allowsSendVoice = self.allowsSendVoice
        self.messageInputView.allowsSendMultiMedia = self.allowsSendMultiMedia
        self.messageInputView.translatesAutoresizingMaskIntoConstraints = false
        //        self.messageInputView.inputTextView.delegate = self
        //        self.messageInputView.delegate = self
        self.addSubview(messageInputView)
        
        
        //多媒体工具栏
        self.shareMenuView = ATShareMenuView()
        self.shareMenuView.translatesAutoresizingMaskIntoConstraints = false
        shareMenuView.backgroundColor = UIColor(white: 0.961, alpha: 1)
        self.addSubview(self.shareMenuView)
        
        //约束布局
        self.setupViewConstraints();
        
    }
    
    /**
     配置视图组件约束
     */
    func setupViewConstraints() {
        
        let views: [String: Any] = [
            "tableView": self.tableView,
            "messageInputView": self.messageInputView,
//            "headerView": self.headerView,
//            "progressViewLoadMore": self.progressViewLoadMore,
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
        
        //        self.headerView.addConstraints(NSLayoutConstraint.constraints(
        //            withVisualFormat: "V:|[progressViewLoadMore]|",
        //            options: NSLayoutFormatOptions(),
        //            metrics: nil,
        //            views:views))
        //
        //        self.headerView.addConstraints(NSLayoutConstraint.constraints(
        //            withVisualFormat: "H:|[progressViewLoadMore]|",
        //            options: NSLayoutFormatOptions(),
        //            metrics: nil,
        //            views:views))
        
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
        
        // KVO 检查contentSize
        self.messageInputView.inputTextView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
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
        self.tableViewScrollToBottomAnimated(false)
    }
    
    
    /// 把表格滚回到底部
    ///
    /// - Parameter animated: 是否显示动画
    public func tableViewScrollToBottomAnimated(_ animated: Bool) {
        if !isTableScrollToBottom {
            if self.messages.count == 0 {
                return
            }
            
            //滚动到底部
            self.adapter.scroll(to: self.messages.last!, supplementaryKinds: nil, scrollDirection: .vertical, scrollPosition: .bottom, animated: animated)

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
        toTopPosition: Bool = true,
        isScrollToBottom: Bool = true,
        delayLoad: Double = 0) {
        if toTopPosition {
            self.messages = chatMessages + self.messages
            
            
            self.loadingMoreData = false
            
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delayLoad * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
//
//                if isScrollToBottom {
//                    self.tableViewScrollToBottomAnimated(true)
//                }
//
//
//            }
            
        } else {
            self.messages = self.messages + chatMessages
            
//            self.adapter.performUpdates(animated: true, completion: nil)
//
//            if isScrollToBottom {
//                self.tableViewScrollToBottomAnimated(true)
//            }
        }
        
        self.adapter.performUpdates(animated: false) {
            (flag) in
            if isScrollToBottom {
                self.tableViewScrollToBottomAnimated(false)
            }
        }
        
    }
}


// MARK: - 实现表格代理方法
extension ATChatMessageView: ListAdapterDataSource {
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.messages as! [ListDiffable]
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ATMessageTextSection()
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

//MARK: textView代理事件
extension ATChatMessageView: UITextViewDelegate{
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            //提交
//            self.sendMessage()
            
            return false
        }
        
        return true;
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

