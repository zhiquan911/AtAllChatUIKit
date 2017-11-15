//
//  DemoView.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/6.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import IGListKit
import AsyncDisplayKit

class DemoView: UIView, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    }()
    
    let collectionView = ASCollectionNode(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    lazy var items = Array(0...20)
    var loading = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
//        self.backgroundColor = UIColor.white
//        collectionView.backgroundColor = UIColor.white
        self.adapter.setASDKCollectionNode(self.collectionView)
//        adapter.collectionView = collectionView
        self.adapter.dataSource = self
        self.addSubnode(collectionView)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let objects = items as [ListDiffable]
        
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return LabelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

final class LabelSectionController: ListSectionController, ASSectionController {
    
    private var object: String?
    
    public func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        let textAttributes : NSDictionary = [
            NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline),
            NSAttributedStringKey.foregroundColor: UIColor.gray
        ]
        let textInsets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 0)
        let textCellNode = ASTextCellNode(attributes: textAttributes as! [AnyHashable : Any], insets: textInsets)
        textCellNode.text = String(format: "Section %zd", index + 1)

        return {
            return textCellNode
        }
    }
    
    override open func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
    
//    override func sizeForItem(at index: Int) -> CGSize {
//        return CGSize(width: collectionContext!.containerSize.width, height: 55)
//    }
//
//    override func cellForItem(at index: Int) -> UICollectionViewCell {
//        guard let cell = collectionContext?.dequeueReusableCell(of: LabelCell.self, for: self, at: index) as? LabelCell else {
//            fatalError()
//        }
//        cell.text = object
//        return cell
//    }

    
    override func didUpdate(to object: Any) {
        self.object = String(describing: object)
    }
    
}


final class LabelCell: UICollectionViewCell {
    
    fileprivate static let insets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    fileprivate static let font = UIFont.systemFont(ofSize: 17)
    
    static var singleLineHeight: CGFloat {
        return font.lineHeight + insets.top + insets.bottom
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSAttributedStringKey.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom
    }
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = LabelCell.font
        return label
    }()
    
    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1).cgColor
        return layer
    }()
    
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.layer.addSublayer(separator)
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        label.frame = UIEdgeInsetsInsetRect(bounds, LabelCell.insets)
        let height: CGFloat = 0.5
        let left = LabelCell.insets.left
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
    
}

extension LabelCell: ListBindable {
    
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? String else { return }
        label.text = viewModel
    }
    
}


class ImageCellNode: ASCellNode {
    let imageNode = ASImageNode()
    required init(with image : UIImage) {
        super.init()
        imageNode.image = image
        self.addSubnode(self.imageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var imageRatio: CGFloat = 0.5
        if imageNode.image != nil {
            imageRatio = (imageNode.image?.size.height)! / (imageNode.image?.size.width)!
        }
        
        let imagePlace = ASRatioLayoutSpec(ratio: imageRatio, child: imageNode)
        
        let stackLayout = ASStackLayoutSpec.horizontal()
        stackLayout.justifyContent = .start
        stackLayout.alignItems = .start
        stackLayout.style.flexShrink = 1.0
        stackLayout.children = [imagePlace]
        
        return  ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: stackLayout)
    }
    
}
