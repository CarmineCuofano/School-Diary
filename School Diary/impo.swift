//
//  impo.swift
//  School Diary
//
//  Created by Carmine Cuofano on 18/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import  UIKit

class impo: UITableViewController {


    let info : [[(title:String,image:UIImage,segueVCId:String,act:Selector? )]] = [[(title:"Materie",image:#imageLiteral(resourceName: "book"),segueVCId:"addMateria",act:nil),(title:"Il nostro facebook",image:#imageLiteral(resourceName: "fb"),segueVCId:"addMateria",act: #selector(impo.apriFB)),(title:"Ringraziamenti",image:#imageLiteral(resourceName: "info"),segueVCId:"credits",act: nil)]]

    @objc func apriFB () {
        self.openFaceBookUrl()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.title = "Impostazioni"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.info.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.info[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath)
        cell.imageView?.image = info[indexPath.section][indexPath.row].image
        cell.textLabel?.text = info[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func openVc(_ id:String) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: id) else { return }
        self.show(vc, sender: self)
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Principali" : nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let act = info[indexPath.section][indexPath.row].act {
            perform(act)
        } else {
            self.openVc(info[indexPath.section][indexPath.row].segueVCId)
        }
    }

}
