//
//  Datamanager.swift
//  School Diary
//
//  Created by Carmine Cuofano on 18/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit
import SafariServices
import AudioToolbox

class Datamanager: NSObject {
    static let sharedIntance = Datamanager()

    var startDate :  Date { return Date.from(string: "12/09/2017")! }
    var middleDate : Date { return Date.from(string: "19/01/2018")! }
    var endDate :    Date { return Date.from(string: "08/06/2018")! }
    var isFirstQuad : Bool { return Date() > startDate && Date() < middleDate }
    var firstQuad : quadModel = quadModel()
    var secondQuad : quadModel = quadModel()
    var current : quadModel { return isFirstQuad ? firstQuad : secondQuad }

    func loadInfo () {
        if isFirstQuad {
            guard let decoded  = UserDefaults.standard.object(forKey: "firstQuad") as? Data else { return }
            guard let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? quadModel else { return }
            self.firstQuad = decodedTeams
        } else {
            guard let decoded  = UserDefaults.standard.object(forKey: "secondQuad") as? Data else { return }
            guard let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? quadModel else { return  }
            self.secondQuad = decodedTeams
        }
    }

    func saveInfo () {
        Datamanager.sharedIntance.current.materie = Datamanager.sharedIntance.current.materie .sorted { $0.nome.localizedCaseInsensitiveCompare($1.nome) == ComparisonResult.orderedAscending }
        if isFirstQuad {
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.firstQuad)
            UserDefaults.standard.set(encodedData, forKey: "firstQuad")
        } else {
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.secondQuad)
            UserDefaults.standard.set(encodedData, forKey: "secondQuad")
        }
            UserDefaults.standard.synchronize()
    }


    func openUrl(url:URL,inVc:UIViewController) {
        let sfController = SFSafariViewController(url: url)
        sfController.preferredBarTintColor = inVc.view.backgroundColor!
        inVc.present(sfController, animated: true, completion: nil)
    }


    func showMessage ( title: String, message:String?, buttons: [(title:String,style:UIAlertActionStyle,action: ((UIAlertAction) -> Void)?)], style:UIAlertControllerStyle, inView:UIViewController, secondsToHide: Int, completion: @escaping () -> () = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for button in buttons {
            alert.addAction(UIAlertAction(title: button.title, style: button.style, handler: button.action))
        }
        inView.present(alert, animated: true, completion: {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        })
        if secondsToHide > 0 { DispatchOnce.perform(TimeInterval(secondsToHide), completion: { alert.dismiss(animated: true, completion: nil) ; completion() }) }
    }
}
