//
//  detailMateria.swift
//  School Diary
//
//  Created by Carmine Cuofano on 19/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class detailMateria: UIViewController, UITableViewDelegate , UITableViewDataSource, didTapOnCellDelegate {

    @IBOutlet var tableView: UITableView!
    var infoModel : materieModel!
    var indexOfModel : Int!
    var oldInsets : UIEdgeInsets!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.oldInsets = self.tableView.contentInset
        NotificationCenter.default.addObserver(self, selector: #selector(addMaterie.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addMaterie.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cella = self.tableView.dequeueReusableCell(withIdentifier: "cellWithField", for: indexPath) as! cellWithField
                cella.field.text = infoModel.nome
                cella.field.placeholder = "Aggiungi materia"
                cella.myIndexPath = indexPath
                cella.tag = 0
                cella.delegate = self
                return cella
            } else {
                let cella = self.tableView.dequeueReusableCell(withIdentifier: "cellaColor", for: indexPath) as! detailCollectionColor
                cella.indexSelected = cella.colors.index(of: infoModel.colore)
                cella.collection.scrollToItem(at: IndexPath(row: cella.indexSelected!, section: 0), at: .centeredHorizontally, animated: true)
                cella.delegate = self
                return cella
            }
        } else {
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                let cella = self.tableView.dequeueReusableCell(withIdentifier: "cellWithField", for: indexPath) as! cellWithField
                cella.field.placeholder = indexPath.row == 0 ? "Aggiungi professore" : indexPath.row == 1 ? "Aggiungi aula" : "Fissati un obiettivo"
                cella.field.text = indexPath.row == 0 ? infoModel.prof : indexPath.row == 1 ? infoModel.aula : "\(infoModel.goal)"
                cella.field.keyboardType = indexPath.row == 2 ? .numbersAndPunctuation : .default
                cella.delegate = self
                cella.myIndexPath = indexPath
                cella.tag = indexPath.section + indexPath.row
                return cella
            } else {
                let cella = self.tableView.dequeueReusableCell(withIdentifier: "cellaText", for: indexPath) as! dettaglioMateriaInfo
                cella.delegate = self
                cella.myIndexPath = indexPath
                cella.textView.text = infoModel.customInfo
                cella.setMode()
                cella.tag = 4
                return cella
           }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? indexPath.row == 0 ? 44 : 75 : indexPath.row == 0 ? 44 : indexPath.row == 1 ? 44 : indexPath.row == 2 ? 44 : 150
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Informazioni" : nil
    }

    deinit { NotificationCenter.default.removeObserver(self) }

    // MARK: Keyboard Notifications

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
           UIView.animate(withDuration: 0.2, animations: {
            self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0)

            //self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset
        })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableView.contentInset = self.oldInsets
        })
    }

    func didTapForColor(color: UIColor) {
        self.infoModel.colore = color
        self.save()
    }

    func didTapForString(string: String?, info: String?) {
        guard let info = info else { return }
        switch info {
        case "materia" : self.didTapForMat(materia: string)
        case "goal" : self.didTapForGoal(goal: string)
        case "info" : self.didTapForInfo(info: string)
        case "aula" : self.didTapForAula(aula: string)
        case "prof" : self.didTapForProf(prof: string)
        default: break
        }
        self.save()
    }

    func didTapForMat(materia: String?) {
        guard let materia = materia else {
            self.showMessageError(message: "L'obiettivo inserito non è valido") ; return
        }
        if materia == "" {
            self.showMessageError(message: "La materia inserita non è valida") ; return
        } else {
            self.infoModel.nome = materia
        }
    }

    func didTapForProf(prof: String?) {
        self.infoModel.prof = prof
    }

    func didTapForAula(aula: String?) {
        self.infoModel.aula = aula
    }

    func didTapForGoal(goal: String?) {
        guard let numberString = goal?.replacingOccurrences(of: ",", with: ".") else {
            self.showMessageError(message: "L'obiettivo inserito non è valido") ; return
        }
        guard let double = Double(numberString) else {
            self.showMessageError(message: "L'obiettivo inserito non è valido") ; return
        }
        if double <= 10 && double >= 0 {
            self.infoModel.goal = double
        } else {
            self.showMessageError(message: "L'obiettivo inserito non è valido") ; return
        }
    }

    func didTapForInfo(info: String?) {
        self.infoModel.customInfo = info
        self.save()
    }

    func save() {
        Datamanager.sharedIntance.current.materie[indexOfModel] = infoModel
        Datamanager.sharedIntance.saveInfo()
        self.view.endEditing(true)
    }

    func showMessageError(message: String) {
        Datamanager.sharedIntance.showMessage(title: "Attenzione", message: message, buttons: [], style: .alert, inView: self, secondsToHide: 5,completion: {
        })
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
