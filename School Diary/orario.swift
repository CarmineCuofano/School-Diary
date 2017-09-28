//
//  ViewController.swift
//  SpreadsheetView
//
//  Created by Carmine Cuofano 5/7/17.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import SpreadsheetView

class orario: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    @IBOutlet weak var spreadsheetView: SpreadsheetView!

    let dates : [String] = ["", "", "", "", "", "", ""]
    let days = ["MONDAY", "TUESDAY", "WEDNSDAY", "THURSDAY", "FRIDAY", "SATURDAY"]
    let dayColors = [UIColor(red: 0.918, green: 0.224, blue: 0.153, alpha: 1),
                     UIColor(red: 0.106, green: 0.541, blue: 0.827, alpha: 1),
                     UIColor(red: 0.200, green: 0.620, blue: 0.565, alpha: 1),
                     UIColor(red: 0.953, green: 0.498, blue: 0.098, alpha: 1),
                     UIColor(red: 0.400, green: 0.584, blue: 0.141, alpha: 1),
                     UIColor(red: 0.835, green: 0.655, blue: 0.051, alpha: 1)]
    let hours = ["1° ora","2° ora","3° ora","4° ora","5° ora","6° ora","7° ora","8° ora"]
    let evenRowColor = UIColor(red: 0.914, green: 0.895, blue: 0.906, alpha: 1)
    let oddRowColor: UIColor = UIColor(red: 0.914, green: 0.914, blue: 0.906, alpha: 0.657)
    var data : [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarItem()
        self.title = "Orario"

        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self

        spreadsheetView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)

        spreadsheetView.intercellSpacing = CGSize(width: 4, height: 1)
        spreadsheetView.gridStyle = .none

        spreadsheetView.register(DateCell.self, forCellWithReuseIdentifier: String(describing: DateCell.self))
        spreadsheetView.register(TimeTitleCell.self, forCellWithReuseIdentifier: String(describing: TimeTitleCell.self))
        spreadsheetView.register(TimeCell.self, forCellWithReuseIdentifier: String(describing: TimeCell.self))
        spreadsheetView.register(DayTitleCell.self, forCellWithReuseIdentifier: String(describing: DayTitleCell.self))
        spreadsheetView.register(ScheduleCell.self, forCellWithReuseIdentifier: String(describing: ScheduleCell.self))
        self.getData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spreadsheetView.flashScrollIndicators()
    }

    func getData() {
        var data : [[String]] = []
        for value in Datamanager.sharedIntance.current.orario {
            var orarioDelGiorno : [String] = []
            for val in value { orarioDelGiorno.append(val.materia.nome.isEmpty ? "" : "\(val.materia.nome)\n\(val.subtitle)") }
            data.append(orarioDelGiorno)
        }
        self.data = data
    }

    // MARK: DataSource

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + days.count
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + 1 + hours.count
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return 70
        } else {
            return 120
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row {
            return 24
        } else if case 1 = row {
            return 32
        } else {
            return 40
        }
    }

    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 2
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if case (1...(dates.count + 1), 0) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: DateCell.self), for: indexPath) as! DateCell
            cell.label.text = dates[indexPath.column - 1]
            return cell
        } else if case (1...(days.count + 1), 1) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: DayTitleCell.self), for: indexPath) as! DayTitleCell
            cell.label.text = days[indexPath.column - 1]
            cell.label.textColor = dayColors[indexPath.column - 1]
            return cell
        } else if case (0, 1) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeTitleCell.self), for: indexPath) as! TimeTitleCell
            cell.label.text = "TIME"
            return cell
        } else if case (0, 2...(hours.count + 2)) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeCell.self), for: indexPath) as! TimeCell
            cell.label.text = hours[indexPath.row - 2]
            cell.label.textAlignment = .left
            cell.backgroundColor = indexPath.row % 2 == 0 ? evenRowColor : oddRowColor
            return cell
        } else if case (1...(days.count + 1), 2...(hours.count + 2)) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ScheduleCell.self), for: indexPath) as! ScheduleCell
            cell.label.text = nil
            cell.color = indexPath.row % 2 == 0 ? evenRowColor : oddRowColor
            cell.borders.top = .none
            cell.borders.bottom = .none
            if data.indices.contains(indexPath.column - 1) {
                if data[indexPath.column - 1].indices.contains(indexPath.row - 2) {
                    let text = data[indexPath.column - 1][indexPath.row - 2]
                    if !text.isEmpty {
                        let comps = text.components(separatedBy: "\n")
                        let attrString = NSMutableAttributedString(string: comps[0],
                                                                   attributes: [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14) ])
                        if !comps.last!.isEmpty {

                            attrString.append(NSAttributedString(string: "\n"))

                            attrString.append(NSMutableAttributedString(string: comps[1],
                                                                        attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9) ]))
                        }

                        cell.label.attributedText = attrString
                        let color = dayColors[indexPath.column - 1]
                        cell.label.textColor = color
                        cell.color = color.withAlphaComponent(0.2)
                        cell.borders.top = .solid(width: 2, color: color)
                        cell.borders.bottom = .solid(width: 2, color: color)
                    }
                }
            }
            
            return cell
        }
        return nil
    }

    /// Delegate

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "Inserisci materia", preferredStyle: .alert)
        alert.addTextField { (field) in
            let defaultPl =  Datamanager.sharedIntance.current.orario[indexPath.column - 1][indexPath.row - 2].materia.nome
            field.placeholder = defaultPl.isEmpty ? "Materia..." : defaultPl
        }
        alert.addTextField { (field) in
            let defaultPl =  Datamanager.sharedIntance.current.orario[indexPath.column - 1][indexPath.row - 2].subtitle
            field.placeholder =  defaultPl.isEmpty ? "Sottotitolo..." : defaultPl
        }
        let actAnnulla = UIAlertAction(title: "Annulla", style: .destructive, handler: nil)
        let actConferma = UIAlertAction(title: "Conferma", style: .default, handler: { (act) in
            Datamanager.sharedIntance.current.orario[indexPath.column - 1][indexPath.row - 2].materia.nome = alert.textFields?.first?.text ?? ""
            Datamanager.sharedIntance.current.orario[indexPath.column - 1][indexPath.row - 2].subtitle = alert.textFields?[1].text ?? ""
            Datamanager.sharedIntance.saveInfo()
            self.getData()
            self.spreadsheetView.reloadData()
        })
        alert.addAction(actAnnulla)
        alert.addAction(actConferma)
        self.present(alert, animated: true, completion: nil)
    }
}

