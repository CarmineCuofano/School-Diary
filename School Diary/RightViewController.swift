//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class RightViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        self.table.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Datamanager.sharedIntance.current.materie.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = table.dequeueReusableCell(withIdentifier: "cella", for: indexPath)
        let scritti = String(describing: self.calculateVotes(materia: Datamanager.sharedIntance.current.materie[indexPath.section]).scritti)
        let orali = String(describing: self.calculateVotes(materia: Datamanager.sharedIntance.current.materie[indexPath.section]).orali)
        let pratici = String(describing: self.calculateVotes(materia: Datamanager.sharedIntance.current.materie[indexPath.section]).pratici)
        let gen = String(describing: self.calculateVotes(materia: Datamanager.sharedIntance.current.materie[indexPath.section]).generale)
        switch indexPath.row {
        case 0:
            cella.textLabel?.text = "Voti generali: \(gen.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: ",", with: " -"))"
        case 1:
            cella.textLabel?.text = "Voti scritti: \(scritti.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: ",", with: " -"))"
        case 2:
            cella.textLabel?.text = "Voti orali: \(orali.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: ",", with: " -"))"
        case 3:
            cella.textLabel?.text = "Voti pratici: \(pratici.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: ",", with: " -"))"
        default: break
        }
        return cella
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Datamanager.sharedIntance.current.materie[section].nome), obiettivo: \(Datamanager.sharedIntance.current.materie[section].goal)"
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func calculateVotes (materia: materieModel)  -> (scritti:[Double], orali:[Double], pratici:[Double], generale: [Double]) {
        let scrittiToRet = self.calculateNumber(voti: materia.voti.scritti.compactMap({ (model) -> Double in model.voto }), goal: materia.goal)
        let oraliToRet = self.calculateNumber(voti: materia.voti.orali.compactMap({ (model) -> Double in model.voto }), goal: materia.goal)
        let praticiToRet = self.calculateNumber(voti: materia.voti.pratici.compactMap({ (model) -> Double in model.voto }), goal: materia.goal)
        let generalToRet = self.calculateNumber(voti: materia.voti.compactMap({ (model) -> Double in model.voto }), goal: materia.goal)
        return (scritti:scrittiToRet, orali:oraliToRet, pratici:praticiToRet, generale: generalToRet)
    }
                                                    
    func calculateNumber (voti: [Double] ,goal:Double) -> [Double] {
        if goal > 10 || goal < 0 { return [] }
        let calculedVoto = ( goal * Double(voti.count + 1) ) - voti.reduce(0, +)
        var arrayVoti : [Double] = []
        if calculedVoto > 10 {
            var votes : [Double] = [calculedVoto]
            var current : Int = 0
            while votes.contains(where: { (double) -> Bool in double > 10 }) {
                votes.append(votes[current] - 10 + goal)
                votes.remove(at: current)
                if votes.count == 1 { votes.insert(10, at: 0) } else { votes.insert(10, at: votes.indices.last! - 1) }
                current += 1
            }
            arrayVoti += votes
            current = 0
        } else if calculedVoto < 0 {
            var votes : [Double] = [calculedVoto]
            var current : Int = 0
            while votes.contains(where: { (double) -> Bool in double < 0 }) {
                votes.append(votes[current] + goal)
                votes.remove(at: current)
                if votes.count == 1 { votes.insert(0, at: 0) } else { votes.insert(0, at: votes.indices.last! - 1) }
                current += 1
            }
            arrayVoti += votes
            current = 0
        } else {
            arrayVoti = [calculedVoto]
        }
        return arrayVoti
    }
}

