//
//  orario.swift
//  School Diary
//
//  Created by Carmine Cuofano on 18/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class orarioModel: NSObject, NSCoding {
    var materia : materieModel, subtitle:String

    override init() {
        self.materia = materieModel()
        self.subtitle = ""
    }

    init(materia : materieModel, subtitle:String) {
        self.materia = materia
        self.subtitle = subtitle
    }

    required convenience init(coder aDecoder: NSCoder) {
        let materia = aDecoder.decodeObject(forKey: "materia") as? materieModel ?? materieModel()
        let subtitle = aDecoder.decodeObject(forKey: "subtitle") as? String ?? ""
        self.init(materia : materia, subtitle:subtitle)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.materia, forKey: "materia")
        aCoder.encode(self.subtitle, forKey: "subtitle")
    }
}
