//
//  Array+extension.swift
//  light_guide
//
//  Created by Chance on 15/10/8.
//  Copyright © 2015年 wetasty. All rights reserved.
//

import Foundation
extension Array where Element: Equatable {
    mutating func removeObject(_ object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjectsInArray(_ array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
    
    func Object(after object: Element) -> Element? {
        let element: Element?
        guard var index = self.index(of: object) else {
            return nil
        }
        guard (index + 1) < self.count else {
            return nil
        }
        element = self[index + 1]
        return element
    }
}
