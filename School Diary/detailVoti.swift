//
//  detailVoti.swift
//  School Diary
//
//  Created by Carmine Cuofano on 21/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class detailVoti: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var switcher: UISegmentedControl!
    var indexOfMateria: Int!
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        self.table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.table.delegate = self
        self.table.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datamanager.sharedIntance.current.materie[indexOfMateria].voti.filtraPer(index: switcher.selectedSegmentIndex).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath)
        let info =  Datamanager.sharedIntance.current.materie[indexOfMateria].voti.filtraPer(index: switcher.selectedSegmentIndex)[indexPath.row]
        cella.textLabel?.text = "\(info.voto.votoDescription)"
        cella.detailTextLabel?.text = "\(info.data.description)"
        return cella
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Elimina"
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let model = Datamanager.sharedIntance.current.materie[indexOfMateria].voti.filtraPer(index: switcher.selectedSegmentIndex)[indexPath.row]
        guard let indexOf = Datamanager.sharedIntance.current.materie[indexOfMateria].voti.index(of: model) else { print("no") ; return }
        Datamanager.sharedIntance.current.materie[indexOfMateria].voti.remove(at: indexOf)
        Datamanager.sharedIntance.saveInfo()
        self.table.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentVoto()
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        self.presentVoto()
    }

    func presentVoto () {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "aggiungiVoti") as? aggiungiVoti else { return }
        vc.indexMat = self.indexOfMateria
        guard let indexPath = self.table.indexPathForSelectedRow else { self.present(vc, animated: true, completion: nil) ; return }
        vc.indexVoto = indexPath.row
        vc.modelVoti = Datamanager.sharedIntance.current.materie[indexOfMateria].voti[indexPath.row]
        self.present(vc, animated: true, completion: nil)
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


