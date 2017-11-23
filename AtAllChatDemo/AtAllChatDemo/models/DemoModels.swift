//
//  DemoModels.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/22.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import Foundation
import AIChatKit
import AIPushDepOCKit
import AIPushKit


/// 获取用户用例数据
///
/// - Returns:
func GetUsers() -> [AIUserInfo] {
    let li = AIUserInfo()
    li.username = "lilei@atall.io"
    li.nickname = "Li Lei"
    li.avatarUrl = "https://www.exx.com/src/images/userhead/u013.jpg"
    li.userkey = AICommonCrypto.sha256(li.username + AIPush.getAppKey())
//    li.userkey = "cba556593157f1dc01a8b2f422219691babcd40c25c1fe3f189321554ebd515d"
    
    let han = AIUserInfo()
    han.username = "hanmeimei@atall.io"
    han.nickname = "Han Meimei"
    han.avatarUrl = "https://www.exx.com/src/images/userhead/u014.jpg"
    han.userkey = AICommonCrypto.sha256(han.username + AIPush.getAppKey())
    
    return [li, han]
}
