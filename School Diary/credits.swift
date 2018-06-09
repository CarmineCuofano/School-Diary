//
//  credits.swift
//  School Diary
//
//  Created by Carmine Cuofano on 29/09/17.
//  Copyright © 2017 Carmine Cuofano. All rights reserved.
//

import UIKit

class credits: UIViewController {

    @IBOutlet var label: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = """
        Per sviluppare l'applicazione abbiamo utilizzato immagini non di nostra proprietà, le abbiamo prese da qui: https://it.icons8.com
        L'applicazione è stata sviluppata da Carmine Cuofano
        """
        title = "Ringraziamenti"
        self.navigationController?.navigationBar.backItem?.title = "Impostazioni"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
