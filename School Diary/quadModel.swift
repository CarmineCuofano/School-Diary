//
//  quadModel.swift
//  School Diary
//
//  Created by Carmine Cuofano on 18/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class quadModel: NSObject, NSCoding {

    var materie : [materieModel],orario: [[orarioModel]]

    override init() {
        self.materie = [
            materieModel(nome: "Arte", prof: nil, aula: nil, colore: .blue, goal: 6,customInfo: nil, voti: []),
            materieModel(nome: "Ginnastica", prof: nil, aula: nil, colore: .green, goal: 6,customInfo: nil, voti: []),
            materieModel(nome: "Geostoria", prof: nil, aula: nil, colore: .red, goal: 6,customInfo: nil, voti: []),
            materieModel(nome: "Inglese", prof: nil, aula: nil, colore: .lightGray, goal: 6,customInfo: nil, voti: []),
            materieModel(nome: "Italiano", prof: nil, aula: nil, colore: .yellow, goal: 6,customInfo: nil,voti: []),
            materieModel(nome: "Matematica", prof: nil, aula: nil, colore: .brown, goal: 6,customInfo: nil, voti: []),
            materieModel(nome: "Religione", prof: nil, aula: nil, colore: .cyan, goal: 6,customInfo: nil, voti: [])
        ]
        self.orario = [
                 /* lunedi */ [
                /* 1° ora */   orarioModel(materia: materieModel(), subtitle: ""),
                /* 2° ora */     orarioModel(materia: materieModel(), subtitle: ""),
                /* 3° ora */     orarioModel(materia: materieModel(), subtitle: ""),
                /* 4° ora */     orarioModel(materia: materieModel(), subtitle: ""),
                /* 5° ora */    orarioModel(materia: materieModel(), subtitle: ""),
                /* 6° ora */     orarioModel(materia: materieModel(), subtitle: ""),
                /* 7° ora */     orarioModel(materia: materieModel(), subtitle: ""),
                /* 8° ora */      orarioModel(materia: materieModel(), subtitle: ""),
                        ],
            /* martedi */ [
            /* 1° ora */     orarioModel(materia: materieModel(), subtitle: ""),
            /* 2° ora */     orarioModel(materia: materieModel(), subtitle: ""),
            /* 3° ora */     orarioModel(materia: materieModel(), subtitle: ""),
            /* 4° ora */     orarioModel(materia: materieModel(), subtitle: ""),
             /* 5° ora */    orarioModel(materia: materieModel(), subtitle: ""),
            /* 6° ora */     orarioModel(materia: materieModel(), subtitle: ""),
            /* 7° ora */     orarioModel(materia: materieModel(), subtitle: ""),
             /* 8° ora */    orarioModel(materia: materieModel(), subtitle: ""),
                          ],
          /* mercoledi */ [
          /* 1° ora */     orarioModel(materia: materieModel(), subtitle: ""),
          /* 2° ora */     orarioModel(materia: materieModel(), subtitle: ""),
          /* 3° ora */     orarioModel(materia: materieModel(), subtitle: ""),
          /* 4° ora */     orarioModel(materia: materieModel(), subtitle: ""),
           /* 5° ora */    orarioModel(materia: materieModel(), subtitle: ""),
         /* 6° ora */     orarioModel(materia: materieModel(), subtitle: ""),
         /* 7° ora */     orarioModel(materia: materieModel(), subtitle: ""),
             /* 8° ora */    orarioModel(materia: materieModel(), subtitle: ""),
                          ],
           /* giovedi */ [
        /* 1° ora */     orarioModel(materia: materieModel(), subtitle: ""),
  /* 2° ora */           orarioModel(materia: materieModel(), subtitle: ""),
        /* 3° ora */     orarioModel(materia: materieModel(), subtitle: ""),
          /* 4° ora */    orarioModel(materia: materieModel(), subtitle: ""),
            /* 5° ora */  orarioModel(materia: materieModel(), subtitle: ""),
     /* 6° ora */        orarioModel(materia: materieModel(), subtitle: ""),
   /* 7° ora */          orarioModel(materia: materieModel(), subtitle: ""),
         /* 8° ora */    orarioModel(materia: materieModel(), subtitle: ""),
                      ],
        /* venerdi */ [
        /* 1° ora */     orarioModel(materia: materieModel(), subtitle: ""),
        /* 2° ora */     orarioModel(materia: materieModel(), subtitle: ""),
       /* 3° ora */     orarioModel(materia: materieModel(), subtitle: ""),
      /* 4° ora */     orarioModel(materia: materieModel(), subtitle: ""),
      /* 5° ora */    orarioModel(materia: materieModel(), subtitle: ""),
     /* 6° ora */     orarioModel(materia: materieModel(), subtitle: ""),
    /* 7° ora */     orarioModel(materia: materieModel(), subtitle: ""),
   /* 8° ora */    orarioModel(materia: materieModel(), subtitle: ""),
                  ],
     /* Sabato */ [
    /* 1° ora */     orarioModel(materia: materieModel(), subtitle: ""),
  /*   2° ora */     orarioModel(materia: materieModel(), subtitle: ""),
    /* 3° ora */     orarioModel(materia: materieModel(), subtitle: ""),
    /* 4° ora */     orarioModel(materia: materieModel(), subtitle: ""),
     /* 5° ora */    orarioModel(materia: materieModel(), subtitle: ""),
    /* 6° ora */     orarioModel(materia: materieModel(), subtitle: ""),
    /* 7° ora */     orarioModel(materia: materieModel(), subtitle: ""),
     /* 8° ora */    orarioModel(materia: materieModel(), subtitle: ""),
                 ]
        ]
    }

    init(materie : [materieModel],orario: [[orarioModel]]) {
        self.materie = materie
        self.orario = orario
    }

    required convenience init(coder aDecoder: NSCoder) {
        let materie = aDecoder.decodeObject(forKey: "materie") as? [materieModel] ?? []
        let orario = aDecoder.decodeObject(forKey: "orario") as? [[orarioModel]] ?? []
        self.init(materie : materie,orario: orario)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.materie, forKey: "materie")
        aCoder.encode(self.orario, forKey: "orario")
    }

}
