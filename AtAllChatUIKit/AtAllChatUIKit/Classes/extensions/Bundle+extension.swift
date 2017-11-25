//
//  Bundle+extension.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/25.
//

import Foundation

public extension Bundle {
    
    /// AtAllChatUIKit的资源链接
    public static var atchat_bundle: Bundle {
        let bundleURL = Bundle(for: ATChatMessageView.self).url(forResource: "AtAllChatUIKit", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
}
