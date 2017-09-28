//
//  votiModel.swift
//  School Diary
//
//  Created by Carmine Cuofano on 18/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class votiModel: NSObject, NSCoding {

    var voto : Double, tipo: votiType, data:Date,descrizione: String

    override init() {
        self.voto = 0.0
        self.tipo = .scritto
        self.data = Date()
        self.descrizione = ""
    }

    init(voto : Double, tipo: votiType, data:Date,descrizione: String) {
        self.voto = voto
        self.tipo = tipo
        self.data = data
        self.descrizione = descrizione
    }

    required convenience init(coder aDecoder: NSCoder) {
        let voto = aDecoder.decodeDouble(forKey: "voto")
        let tipo = aDecoder.decodeInteger(forKey: "tipo")
        let data = aDecoder.decodeObject(forKey: "data") as? Date ?? Date()
        let descrizione = aDecoder.decodeObject(forKey: "descrizione") as? String ?? ""
        self.init(voto : voto, tipo: votiType(rawValue: tipo)!, data:data,descrizione: descrizione)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.voto, forKey: "voto")
        aCoder.encode(self.tipo.rawValue, forKey: "tipo")
        aCoder.encode(self.data, forKey: "data")
        aCoder.encode(self.descrizione, forKey: "descrizione")
    }

}

enum votiType : Int {
    case scritto = 0
    case orale = 1
    case pratico = 2

}
