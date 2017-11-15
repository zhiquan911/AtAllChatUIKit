//
//  UIImage+extension.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/7.
//  Copyright © 2017年 atall. All rights reserved.
//

import Foundation

extension UIImage {
    
    
    /// 加载框架内部的图片资料
    ///
    /// - Parameter named: 图片名称
    /// - Returns: 图片
    static func loadImage(named: String) -> UIImage? {
        let bundleURL = Bundle(for: ATImage.self).url(forResource: "AtAllChatUIKit", withExtension: "bundle")
        let img = UIImage(named: named, in: Bundle(url: bundleURL!), compatibleWith: nil)
        return img
    }
}


/// 空类，用于框架内读取图片
class ATImage {
    
}
