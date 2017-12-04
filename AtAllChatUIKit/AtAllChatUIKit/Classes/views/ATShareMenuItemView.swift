//
//  ATShareMenuItemView.swift
//  AtAllChatKit
//
//  Created by Chance on 15/10/6.
//  Copyright © 2018年 atall. All rights reserved.
//

import UIKit

open class ATShareMenuItemView: UIView {

    public var lableMenuTitle: UILabel!
    public var buttonMenuItem: UIButton!
    public var menuItemImage: UIImage!
    public var menuItem: String!
    
    private func setupUI() {
        
        if buttonMenuItem == nil {
            let button = UIButton(type: UIButtonType.custom)
            button.frame = CGRect(x: 0, y: 0, width: self.menuItemImage.size.width, height: menuItemImage.size.height)
            button.setImage(menuItemImage, for: .normal)
            button.backgroundColor = UIColor.clear
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setBackgroundImage(UIImage.loadImage(named: "VoiceBtn_black"), for: .normal)
            button.setBackgroundImage(UIImage.loadImage(named: "VoiceBtn_blackHL"), for: .highlighted)
            self.addSubview(button)
            
            self.buttonMenuItem = button
        }
        
        if lableMenuTitle == nil {
            let label = UILabel()
            label.text = self.menuItem
            label.backgroundColor = UIColor.clear
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 13)
            label.textAlignment = NSTextAlignment.center
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            
            self.lableMenuTitle = label;
        }
        
        //水平布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[buttonMenuItem]|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["buttonMenuItem": self.buttonMenuItem]))
        
        //水平布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[lableMenuTitle]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["lableMenuTitle": self.lableMenuTitle]))
        
        //垂直布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[buttonMenuItem(\(menuItemImage.size.height))]",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["buttonMenuItem": self.buttonMenuItem]))
        
        //垂直布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[lableMenuTitle(20)]|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["lableMenuTitle": self.lableMenuTitle]))
        
    }
    
    override open func awakeFromNib() {
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    public convenience init(image: UIImage, title: String) {
        self.init()
        self.menuItemImage = image
        self.menuItem = title
        self.setupUI()
    }

}


// MARK: - 工厂
extension ATShareMenuItemView {
    
    
    /// 图片
    public static var photo: ATShareMenuItemView {
        let shareMenuItem = ATShareMenuItemView(
            image: UIImage.loadImage(named: "sharemore_pic")!,
            title: NSLocalizedString("Photo", bundle: Bundle.atchat_bundle, comment: ""))
        return shareMenuItem
    }
    
    /// 拍照
    public static var photograph: ATShareMenuItemView {
        let shareMenuItem = ATShareMenuItemView(
            image: UIImage.loadImage(named: "sharemore_video")!,
            title: NSLocalizedString("Photograph", bundle: Bundle.atchat_bundle, comment: ""))
        return shareMenuItem
    }
    
    /// 视频
    public static var video: ATShareMenuItemView {
        let shareMenuItem = ATShareMenuItemView(
            image: UIImage.loadImage(named: "sharemore_videovoip")!,
            title: NSLocalizedString("Video", bundle: Bundle.atchat_bundle, comment: ""))
        return shareMenuItem
    }
    
    /// 位置
    public static var location: ATShareMenuItemView {
        let shareMenuItem = ATShareMenuItemView(
            image: UIImage.loadImage(named: "sharemore_location")!,
            title: NSLocalizedString("Location", bundle: Bundle.atchat_bundle, comment: ""))
        return shareMenuItem
    }
    
    /// 名片
    public static var card: ATShareMenuItemView {
        let shareMenuItem = ATShareMenuItemView(
            image: UIImage.loadImage(named: "sharemore_friendcard")!,
            title: NSLocalizedString("Card", bundle: Bundle.atchat_bundle, comment: ""))
        return shareMenuItem
    }
}
