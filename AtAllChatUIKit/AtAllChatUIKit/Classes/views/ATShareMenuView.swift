//
//  SCShareMenuView.swift
//  AtAllChatUIKit
//
//  Created by Chance on 15/10/6.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit

@objc public protocol ATShareMenuViewDelegate {
    
    @objc optional func numberOfShareMenuItem() -> Int
    
    @objc optional func menuItemViewForIndex(index: Int) -> ATShareMenuItemView
    
    //点击多媒体菜单按钮
    @objc optional func didSelectShareMenuItem(itemView: ATShareMenuItemView, atIndex: Int)
}

open class ATShareMenuView: UIView {

    var shareMenuItems = [ATShareMenuItemView]()
    var scrollViewShareMenu: UIScrollView!
    var pageControlShareMenu: UIPageControl!
    weak var delegate: ATShareMenuViewDelegate?
    
    let kPageControlHeight: CGFloat = 30
    let kMenuItemViewWidth: CGFloat = 60
    let kMenuItemViewHeight: CGFloat = 80
    let kMenuItemViewColum: CGFloat = 4
    let KMenuItemViewRow: CGFloat = 2
    
    private func setupUI() {
    
        self.backgroundColor = UIColor(hex: 0xf7f7f7)
        
        if scrollViewShareMenu == nil {
            let shareMenuScrollView = UIScrollView()
            shareMenuScrollView.translatesAutoresizingMaskIntoConstraints = false
//            shareMenuScrollView.delegate = self
            shareMenuScrollView.canCancelContentTouches = false
            shareMenuScrollView.delaysContentTouches = true
            shareMenuScrollView.backgroundColor = self.backgroundColor
            shareMenuScrollView.showsHorizontalScrollIndicator = false
            shareMenuScrollView.showsVerticalScrollIndicator = false
            shareMenuScrollView.scrollsToTop = false
            shareMenuScrollView.isPagingEnabled = true;
            self.addSubview(shareMenuScrollView)
            self.scrollViewShareMenu = shareMenuScrollView;
        }
        
        if pageControlShareMenu == nil {
            let shareMenuPageControl = UIPageControl()
            shareMenuPageControl.translatesAutoresizingMaskIntoConstraints = false
            shareMenuPageControl.backgroundColor = self.backgroundColor;
            shareMenuPageControl.hidesForSinglePage = true;
            shareMenuPageControl.defersCurrentPageDisplay = true;
            self.addSubview(shareMenuPageControl)
            
            self.pageControlShareMenu = shareMenuPageControl;
        }
        
        let views = [
            "scrollViewShareMenu": self.scrollViewShareMenu,
            "pageControlShareMenu": self.pageControlShareMenu
            ] as [String : Any]
        
        //水平布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[scrollViewShareMenu]|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        //水平布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[pageControlShareMenu]|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        //垂直布局
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[scrollViewShareMenu]-[pageControlShareMenu(\(kPageControlHeight))]|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
    }
    
    override open func awakeFromNib() {
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    convenience init(itemImage: UIImage, title: String) {
        self.init()
        self.setupUI()
    }
    
    /**
    刷新数据
    */
    func reloadData() {
        let count = self.delegate?.numberOfShareMenuItem?() ?? 0
        for subview in self.scrollViewShareMenu.subviews {
            subview.removeFromSuperview()
        }
        self.shareMenuItems.removeAll()
        
        //计算每个单元均匀分隔的pading
        let totalWidth = self.bounds.width
        let totalHeight = self.bounds.height
        let totalXMargin: CGFloat = totalWidth - (kMenuItemViewColum * kMenuItemViewWidth)
        let perXMargin = totalXMargin / (kMenuItemViewColum + 1)
        let totalYMargin = totalHeight - kPageControlHeight - (KMenuItemViewRow * kMenuItemViewHeight)
        let perYMargin = totalYMargin / (KMenuItemViewRow + 1)
        
        var itemX: CGFloat = perXMargin
        var itemY: CGFloat = perYMargin
        
        for i in stride(from: 0, to: count, by: 1) {
//        for var i = 0; i<count; i++ {
            guard let itemView = self.delegate?.menuItemViewForIndex?(index: i) else {
                continue
            }
            self.shareMenuItems.append(itemView)
            self.scrollViewShareMenu.addSubview(itemView)
            itemX = CGFloat(i) * (kMenuItemViewWidth + perXMargin) + perXMargin
            let row = i / Int(kMenuItemViewColum)
            itemY = CGFloat(row) * (kMenuItemViewHeight + perYMargin) + perYMargin
            //配置按钮的位置
            let itemFrame = CGRect(x: itemX, y: itemY, width: kMenuItemViewWidth, height: kMenuItemViewHeight)
            itemView.frame = itemFrame
            
            //增加点击事件
            itemView.buttonMenuItem.addTarget(self, action: #selector(handleShareMenuButtonPress(sender:)), for: .touchUpInside)
        }
    }
    
    /**
    点击按钮事件
    
    - parameter sender:
    */
    @objc func handleShareMenuButtonPress(sender: UIButton) {
        let array = NSArray(array: self.shareMenuItems)
        let index = array.index(of: sender.superview!)
        self.delegate?.didSelectShareMenuItem?(itemView: sender.superview as! ATShareMenuItemView, atIndex: index)
    }

}

//class SCShareMenuView: UIScrollViewDelegate {
//
//}
