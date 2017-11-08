//
//  ATChatMessageViewDelegate.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/8.
//  Copyright © 2017年 atall. All rights reserved.
//

import Foundation


/// 聊天视图代理
@objc public protocol ATChatMessageViewDelegate {
    
    /// 是否显示时间轴Label的回调方法
    ///
    /// - Parameters:
    ///   - view: 聊天视图
    ///   - index: 目标消息的位置
    /// - Returns: 根据索引获取消息对象判断是否需要显示时间
    @objc optional func chatView(view: ATChatMessageView, shouldDisplayTime index: Int) -> Bool
    
    /// 配置Cell的样式或者字体
    ///
    /// - Parameters:
    ///   - view: 聊天视图
    ///   - configureCell: 目标Cell
    ///   - index: 目标消息的位置
    /// - Returns:
    @objc optional func chatView(view: ATChatMessageView, configureCell: ATChatMessageViewCell, at index: Int)
    
    /// 判断是否支持下拉加载更多消息
    ///
    /// - Parameter view: 聊天视图
    /// - Returns: 返回BOOL值，判定是否拥有这个功能
    @objc optional func shouldLoadMoreMessagesScrollToTop(view: ATChatMessageView) -> Bool
    
    /// 下拉加载更多消息，只有在支持下拉加载更多消息的情况下才会调用.
    ///
    /// - Parameter view: 聊天视图
    @objc optional func loadMoreMessagesScrollTotop(view: ATChatMessageView)
    
    /// 发送消息
    ///
    /// - Parameters:
    ///   - view: 聊天视图
    ///   - messages: 消息对象数组
    @objc optional func chatView(view: ATChatMessageView, didSendMessage messages: [ATMessageItem])
    
}
