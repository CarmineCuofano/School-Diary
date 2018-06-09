//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: from)...self.endIndex])
    }
    
    var length: Int {
        return self.count
    }

    func size(_ font: UIFont) -> CGSize {
        return NSAttributedString(string: self, attributes: [.font: font]).size()
    }

    func width(_ font: UIFont) -> CGFloat {
        return size(font).width
    }

}
