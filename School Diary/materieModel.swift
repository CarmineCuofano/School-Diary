//
//  materie.swift
//  School Diary
//
//  Created by Carmine Cuofano on 18/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class materieModel: NSObject , NSCoding{

    var nome: String, prof:String?, aula:String?,colore:UIColor,goal: Double,customInfo:String?, voti: [votiModel]

    override init() {
        self.nome = ""
        self.prof = ""
        self.aula = ""
        self.colore = .clear
        self.goal = 6
        self.voti = []
    }

    init(nome: String, prof:String?, aula:String?,colore:UIColor,goal:Double,customInfo:String?, voti: [votiModel]) {
        self.nome = nome
        self.prof = prof
        self.aula = aula
        self.colore = colore
        self.goal = goal
        self.voti = voti
        self.customInfo = customInfo
    }

    required convenience init(coder aDecoder: NSCoder) {
        let nome = aDecoder.decodeObject(forKey: "nome") as? String ?? ""
        let prof = aDecoder.decodeObject(forKey: "prof") as? String
        let aula = aDecoder.decodeObject(forKey: "aula") as? String
        let colore = aDecoder.decodeObject(forKey: "colore") as? UIColor ?? .clear
        let goal = aDecoder.decodeDouble(forKey: "goal")
        let customInfo = aDecoder.decodeObject(forKey: "customInfo") as? String
        let voti = aDecoder.decodeObject(forKey: "voti") as? [votiModel] ?? []
        self.init(nome: nome, prof:prof, aula:aula, colore:colore,goal:goal,customInfo:customInfo,voti: voti)
   }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nome, forKey: "nome")
        aCoder.encode(self.prof, forKey: "prof")
        aCoder.encode(self.aula, forKey: "aula")
        aCoder.encode(self.colore, forKey: "colore")
        aCoder.encode(self.goal, forKey: "goal")
        aCoder.encode(self.voti, forKey: "voti")
        aCoder.encode(self.customInfo, forKey: "customInfo")
    }

}
