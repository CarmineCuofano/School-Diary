//
//  freeCode.swift
//  School Diary
//
//  Created by Carmine Cuofano on 20/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit


public final class /* struct */ DispatchOnce {
    public static func perform(_ withDelay : Double = 0, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + withDelay) { completion() }
    }
}

@objc protocol didTapOnCellDelegate {
    @objc optional func didTapForColor(color: UIColor)
    @objc optional func didTapForString(string: String?, info: String?)
}

enum weekDays : Int{
    case lunedi = 0
    case martedi = 1
    case mercoledi = 2
    case giovedi = 3
    case venerdi = 4
    case sabato = 5
    case domenica = 6
}
extension weekDays {
    var descrizione : String { return String(describing: self) }
}

