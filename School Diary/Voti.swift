//
//  Voti.swift
//  School Diary
//
//  Created by Carmine Cuofano on 17/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class Voti: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.setNavigationBarItem()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.table.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datamanager.sharedIntance.current.materie.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cella = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as! votiMainCell
        let info = Datamanager.sharedIntance.current.materie[indexPath.row]
        cella.materia.text = info.nome
        cella.votiCount.text = info.voti.count == 0 ? "Ancora nessun voto" : info.voti.count == 1 ? "1 voto" : "\(info.voti.count) voti"
        cella.media.text = info.voti.isEmpty ? "-" : "\(info.voti.media)".characters.count > 3 ? "~\(round(info.voti.media))" : "\(info.voti.media)"
        cella.colorView.backgroundColor = info.voti.media.votoColor
        return cella
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailVoti") as? detailVoti else { return }
        vc.indexOfMateria = indexPath.row
        self.show(vc, sender: self)
        self.table.deselectRow(at: indexPath, animated: true)
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
