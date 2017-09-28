//
//  Array.swift
//  School Diary
//
//  Created by Carmine Cuofano on 21/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

 extension Array where Element == votiModel {
    var scritti : [votiModel] { get { return self.filter({ $0.tipo == votiType.scritto }) } set {  } }
    var orali : [votiModel] { get { return self.filter({ $0.tipo == votiType.orale }) } set {} }
    var pratici : [votiModel] { get { return self.filter({ $0.tipo == votiType.pratico }) } set {} }
    var somma : Double { var somma : Double = 0.0 ; for value in self { somma += value.voto } ; return somma }
    var media : Double { return self.somma / Double(self.count) }
    func filtraPer(index: Int) -> [votiModel] {
        switch index {
        case 0: return scritti
        case 1: return orali
        case 2: return pratici
        default: return []
        }
    }
}
extension Array where Element == materieModel {
    var insufficienti : [materieModel] { return self.filter({ $0.voti.media < 6 }) }
    var graviCount  : Int { return insufficienti.filter({ $0.voti.media.isGrave }).count }
}

extension Double {
    var isGrave : Bool { return self < 5.25 }
}
