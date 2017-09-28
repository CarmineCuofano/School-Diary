//
//  aggiungiVoti.swift
//  School Diary
//
//  Created by Carmine Cuofano on 30/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class aggiungiVoti: UIViewController, UITableViewDelegate, UITableViewDataSource, didTapOnCellDelegate {

    @IBOutlet var table: UITableView!

    var isSelectingDate : Bool = false
    var oldInsets : UIEdgeInsets!

    var indexMat : Int! = nil
    var indexVoto : Int! = nil
    var modelVoti : votiModel = votiModel(voto: 6, tipo: .orale, data: Date(), descrizione: "")

    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let indexVoto = indexVoto {
            Datamanager.sharedIntance.current.materie[indexMat].voti[indexVoto] = modelVoti
        } else {
            Datamanager.sharedIntance.current.materie[indexMat].voti.append(modelVoti)
        }
        Datamanager.sharedIntance.saveInfo()
        self.dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.oldInsets = self.table.contentInset
        NotificationCenter.default.addObserver(self, selector: #selector(addMaterie.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addMaterie.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)


        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cella = tableView.dequeueReusableCell(withIdentifier: "cella0", for: indexPath) as! selectSegCell
                cella.delegate = self
                cella.segment.selectedSegmentIndex = modelVoti.tipo.rawValue
                cella.selectionStyle = .none
                return cella
            } else {
                let cella = tableView.dequeueReusableCell(withIdentifier: "cella1", for: indexPath) as! votoAddCell
                cella.delegate = self
                cella.currentVoto  = modelVoti.voto
                cella.selectionStyle = .none
                return cella
            }
        } else if indexPath.section == 1 {
            let cella = tableView.dequeueReusableCell(withIdentifier: "cella2", for: indexPath) as! selectDateCell
            cella.selectDate.isHidden = !isSelectingDate
            cella.delegate = self
            cella.dateLabel.text = modelVoti.data.description
            cella.selectDate.date = modelVoti.data
            cella.selectionStyle = .default
            return cella
        } else {
            let cella = tableView.dequeueReusableCell(withIdentifier: "cella3", for: indexPath) as! dettaglioMateriaInfo
            cella.delegate = self
            cella.textView.text = self.modelVoti.descrizione
            cella.selectionStyle = .none
            cella.myIndexPath = indexPath
            return cella
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isSelectingDate = indexPath.section == 1 && indexPath.row == 0 ? !isSelectingDate : false
        self.table.beginUpdates()
        self.table.reloadRows(at: [indexPath], with: .fade)
        self.table.endUpdates()
        self.table.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 50 : indexPath.section == 1 ? isSelectingDate ? 150 : 50 : 93
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 2 ? "Informazioni" : nil
    }

    deinit { NotificationCenter.default.removeObserver(self) }

    // MARK: Keyboard Notifications

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            UIView.animate(withDuration: 0.2, animations: {
                self.table.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0)

                //self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                self.table.scrollIndicatorInsets = self.table.contentInset
            })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.table.contentInset = self.oldInsets
        })
    }

    func didTapForString(string: String?, info: String?) {
        switch info! {
        case "selectedSegmentIndex" : self.modelVoti.tipo = votiType(rawValue: Int(string!)!)!
        case "voto" : self.modelVoti.voto = Double(string!)!
        case "didTapForDate": self.modelVoti.data = Date.from(string: string!)!
        case "info" : self.modelVoti.descrizione = string ?? ""
        default: break
        }
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
