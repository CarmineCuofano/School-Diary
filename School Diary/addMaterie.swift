//
//  addMaterie.swift
//  School Diary
//
//  Created by Carmine Cuofano on 18/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class addMaterie: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addButton: UIButton!

    @IBOutlet var fieldMateria: UITextField!

    @IBOutlet var table: UITableView!

    @IBAction func addButton(_ sender: UIButton) {
        Datamanager.sharedIntance.current.materie.append(materieModel(nome: self.fieldMateria.text!, prof: nil, aula: nil, colore: .gray, goal: 6,customInfo:nil, voti: []))
        Datamanager.sharedIntance.saveInfo()
        self.fieldMateria.text = nil
        self.fieldMateria.resignFirstResponder()
        self.tableView.reloadData()
    }

    @IBAction func tapRec(_ sender: UITapGestureRecognizer) {
        self.fieldMateria.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "materie"
        self.fieldMateria.delegate = self
        self.table.delegate = self
        self.table.dataSource = self
        self.addButton.isEnabled = false
        self.fieldMateria.addTarget(self, action: #selector(addMaterie.editParam(textField:)), for: .editingChanged)
        self.addButton.setTitleColor(self.addButton.isEnabled ? .red : .gray, for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(addMaterie.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addMaterie.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit { NotificationCenter.default.removeObserver(self) }

    // MARK: Keyboard Notifications

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            self.view.frame.origin.y = -keyboardHeight
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.view.frame.origin.y = 0
        })
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.fieldMateria.resignFirstResponder()
        return true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datamanager.sharedIntance.current.materie.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as! addMaterieCell
        cella.materia.text = Datamanager.sharedIntance.current.materie[indexPath.row].nome
        cella.colore.backgroundColor = Datamanager.sharedIntance.current.materie[indexPath.row].colore
        return cella
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Le tue materie"
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Elimina"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Datamanager.sharedIntance.current.materie.remove(at: indexPath.row)
            Datamanager.sharedIntance.saveInfo()
            self.tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailMateria") as? detailMateria else { return }
        self.tableView.deselectRow(at: indexPath, animated: true)
        vc.infoModel = Datamanager.sharedIntance.current.materie[indexPath.row]
        vc.indexOfModel = indexPath.row
        self.show(vc, sender: self)
    }

    @objc func editParam(textField: UITextField) {
        self.addButton.isEnabled = textField.text == nil ? false : !textField.text!.isEmpty
        self.addButton.setTitleColor(self.addButton.isEnabled ? .red : .gray, for: .normal)
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
