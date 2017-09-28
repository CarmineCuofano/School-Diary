//
//  Double.swift
//  School Diary
//
//  Created by Carmine Cuofano on 21/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

extension Double {
    var votoColor : UIColor {
        return self.isNaN ? .lightGray : self < 5.5 ? .red : self < 6 ? UIColor.yellowSand : .green
    }
    var votoDescription : String {
        let comps = String(self).components(separatedBy: ".")
        let integer : String = comps.first!
        let decimal : String? = comps.indices.contains(1) ? comps[1] : nil
        if let _ = decimal {
            if decimal == "0" {
                return integer
            } else if decimal == "25" {
                return "\(integer)+"
            } else if decimal == "5"{
                return "\(integer) ½"
            } else {
                return "\(Int(integer)! + 1)-"
            }
        } else {
            return integer
        }
    }
}
