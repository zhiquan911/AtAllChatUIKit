//
//  ATAdatpter.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/14.
//

import UIKit
import IGListKit

public class ATListAdapter: ListAdapter {

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        NSLog("scrollViewWillEndDragging")
    }
    
}
