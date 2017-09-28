//
//  Home.swift
//  School Diary
//
//  Created by Carmine Cuofano on 17/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit
typealias indexOrarioType = (row:Int,descrizione:String)

class Home: UIViewController, SlideMenuControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var previsioneLabel: UILabel!
    @IBOutlet var collectInsufficienze: UICollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cointainerView: UIView!
    var indexOfTable :  indexOrarioType!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.previsioneLabel.adjustsFontSizeToFitWidth = true
        self.previsioneLabel.minimumScaleFactor = 0.2
        self.collectInsufficienze.delegate = self
        self.collectInsufficienze.dataSource = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        title = "Home"
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        self.indexOfTable = self.calculateIndex()
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datamanager.sharedIntance.current.orario[indexOfTable.row].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath)
        let  info = Datamanager.sharedIntance.current.orario[indexOfTable.row][indexPath.row]
        cella.textLabel?.text = info.materia.nome.isEmpty ? "Materia" :  info.materia.nome
        cella.detailTextLabel?.text = info.subtitle.isEmpty ? "-" :  info.subtitle
        return cella

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexOfTable.descrizione
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.loadPrev()
    }

    func loadPrev() {
        let prev = self.getPrev()
        self.previsioneLabel.text = prev.string
        self.previsioneLabel.textColor = prev.colore
        self.tableView.reloadData()
    }

    func getPrev() -> (string:String, colore:UIColor) {
        if Datamanager.sharedIntance.current.materie.insufficienti.isEmpty {
            return (string:"Promosso/a", colore:.green)
        } else if Datamanager.sharedIntance.current.materie.insufficienti.count == 1 {
            return Datamanager.sharedIntance.current.materie.insufficienti.first!.voti.media.isGrave ? (string:"Debito",colore: .yellowSand) : (string:"Probabile promozione",colore:.yellowSand)
        } else if Datamanager.sharedIntance.current.materie.insufficienti.count == 2 {
            let first = Datamanager.sharedIntance.current.materie.insufficienti.first!.voti.media
            let second = Datamanager.sharedIntance.current.materie.insufficienti[1].voti.media
            if first.isGrave && second.isGrave {
                return (string:"Debiti", colore:.yellowSand)
            } else if (first.isGrave && !second.isGrave) || (!first.isGrave && second.isGrave) {
                return (string:"Probabile debito", colore:.yellowSand)
            } else {
                return (string:"Rischio debiti", colore:.yellowSand)
            }
        } else if Datamanager.sharedIntance.current.materie.insufficienti.count == 3 {
            if Datamanager.sharedIntance.current.materie.insufficienti.graviCount == 3 {
                return (string:"Bocciatura estremamente probabile", colore:.red)
            } else if Datamanager.sharedIntance.current.materie.insufficienti.graviCount == 2 {
                return (string:"ALTO Rischio bocciatura / Debiti",colore:.red)
            } else if Datamanager.sharedIntance.current.materie.insufficienti.graviCount == 1 {
                return (string:"Debiti / Lieve rischio bocciatura",colore:.yellowSand)
            } else {
                return (string:"Debiti",colore:.yellowSand)
            }
        } else if Datamanager.sharedIntance.current.materie.insufficienti.count == 4  {
            if Datamanager.sharedIntance.current.materie.insufficienti.graviCount <= 1 {
                return (string:"Rischio bocciatura / Debiti", colore:.red)
            } else if Datamanager.sharedIntance.current.materie.insufficienti.graviCount == 2 {
                return (string:"ALTO Rischio bocciatura / Debiti", colore:.red)
            } else {
                return (string:"Bocciatura", colore:.red)
            }
        } else {
            return (string:"Bocciatura", colore:.red)
        }
    }

    func calculateIndex() -> indexOrarioType {
        let indexToday = Calendar.current.component(.weekday, from: Date()) - 1
        if let indexDescription  = weekDays(rawValue: indexToday) {
            return indexToday == 6 ? (row:0, descrizione:"Orario di lunedi") : (row:indexToday , descrizione: "Orario di \(indexDescription.descrizione)")
        }
        return (row:0, descrizione:"errore")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Datamanager.sharedIntance.current.materie.insufficienti.isEmpty ? 1 : Datamanager.sharedIntance.current.materie.insufficienti.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cella = collectInsufficienze.dequeueReusableCell(withReuseIdentifier: "cella", for: indexPath) as! homeCollect
        if  Datamanager.sharedIntance.current.materie.insufficienti.isEmpty {
            cella.labelMateria.text = "Nessuna"
            cella.materiaColor.backgroundColor = .clear
        } else {
            let mod = Datamanager.sharedIntance.current.materie.insufficienti[indexPath.row]
            cella.labelMateria.text = mod.nome
            cella.materiaColor.backgroundColor = mod.voti.media.votoColor
        }
        return cella
    }
    
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}

