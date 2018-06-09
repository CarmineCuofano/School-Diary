//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case Home = 0
    case Voti
    case orario
    case Impo
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Home", "Voti", "Orario", "Impostazioni"]
    var homeViewController: UIViewController!
    var votiViewController: UIViewController!
    var impegniViewController: UIViewController!
    var orarioController: UIViewController!
    var impoController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVc = storyboard.instantiateViewController(withIdentifier: "home") as! Home
        self.homeViewController = UINavigationController(rootViewController: homeVc)
        
        let votiVc = storyboard.instantiateViewController(withIdentifier: "voti") as! Voti
        self.votiViewController = UINavigationController(rootViewController: votiVc)

        let orarioVc = storyboard.instantiateViewController(withIdentifier: "orario") as! orario
        self.orarioController = UINavigationController(rootViewController: orarioVc)

        let impoVc = storyboard.instantiateViewController(withIdentifier: "impo") as! impo
        self.impoController = UINavigationController(rootViewController: impoVc)

        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190)
        self.tableView.frame.origin.y += 30
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .Home:
            self.slideMenuController()?.changeMainViewController(self.homeViewController, close: true)
        case .Voti:
            self.slideMenuController()?.changeMainViewController(self.votiViewController, close: true)
        case .orario:
            self.slideMenuController()?.changeMainViewController(self.orarioController, close: true)
        case .Impo:
            self.slideMenuController()?.changeMainViewController(self.impoController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .Home, .Voti,.orario, .Impo:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .Home, .Voti,.orario ,.Impo:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
