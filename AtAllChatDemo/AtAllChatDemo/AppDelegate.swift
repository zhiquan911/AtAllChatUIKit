//
//  AppDelegate.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/5.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import AIChatKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// 配置AIChat
    func setupAIChat() {
        
        AIChat.setupWithOption(
            appKey: "2d68067484a20f1a346b3cf28a898ed7f5736f5bacf0fe60449da95efdb97ad4",
            secret: "0dd1e322907ad7f55deaa35fec2aac97cae7931454d734364bc63f3e9b9f993a",
            channel: "demo",
            isProduction: false)
        AIChat.addListener(self)
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setupAIChat()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// MARK: - AIChatKit相关方法实现
extension AppDelegate: AIChatListener {
    
    
    func didReceiveAIChatMessage(message: AIChatMessage,conversation: AIConversation) {
        NSLog("AIChat didReceiveAIChatMessage")
        
        //        "chatMessage":
        //        {"content":"5555","msgType":1,"msgid":"8803","receiverkey":"4d140540e6c0b9c4eadc347d1d8c0ea88090667a92445c308b3c4bb854759300","sendTime":1508408197,"senderkey":"4d140540e6c0b9c4eadc347d1d8c0ea88090667a92445c308b3c4bb854759300","title":"5555"},
        //
        //        "conversation":{"conversationName":"Nick","conversationType":"0","conversationid":"8567","lastSendMsgTime":"1508408197","lastSendMsgid":"8803","number":"920956358931517440",
        //
        //            "objectModel":{"allowType":"0","avatarUrl":"","extAttr":"","language":"","msgSettings":"0","nickname":"Nick","online":"1","role":"1","userkey":"4d140540e6c0b9c4eadc347d1d8c0ea88090667a92445c308b3c4bb854759300","username":"Nick"},
        
        //"objectkey":"4d140540e6c0b9c4eadc347d1d8c0ea88090667a92445c308b3c4bb854759300","unreadCount":"1",
        //
        //            "userInfo":{"allowType":"0","avatarUrl":"","extAttr":"","language":"","msgSettings":"0","nickname":"Nick","online":"1","role":"1","userkey":"4d140540e6c0b9c4eadc347d1d8c0ea88090667a92445c308b3c4bb854759300","username":"Nick"}}},
        //
        //            "method":"didReceiveAIChatMessage","protocol":"1","seq":"1508408197","type":"1","ver":"v1"}
        
        
        
        //发送最近对话更新消息
        NotificationCenter.default
            .post(name: Notification.Name(rawValue: "pushConversation"), object: nil)
        
        //发送聊天记录更新消息
        NotificationCenter.default
            .post(name: Notification.Name(rawValue: "pushChatMessage"), object: nil)
        
        
    }
    
    func didReceiveAIGroupTips(operator: AIGroupMember, group: AIGroup, type: String, members: [AIGroupMember]) {
        NSLog("AIChat didReceiveAIGroupTips")
    }
    
    func didReceiveAIGroupSystemNotify(operator: AIGroupMember, group: AIGroup, type: String, reason: String) {
        NSLog("AIChat didReceiveAIGroupSystemNotify")
    }
    
    /// 处理来自AIChatKit的消息通知
    func didConnectionChangedAIChat(isConnected: Bool) {
        NSLog("AIChat 连接服务器状态 = \(isConnected)")
    }
    
    func didReceiveAIFriendshipChange(friendship: AIFriendship, status: String) {
        NSLog("AIChat didReceiveAIFriendshipChange")
    }
    
    func didReceiveAIGroupChange(group: AIGroup, status: String) {
        NSLog("AIChat didReceiveAIGroupChange")
    }
    
    
    
    
}
