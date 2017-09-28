//
//  votoAddCell.swift
//  School Diary
//
//  Created by Carmine Cuofano on 30/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class votoAddCell: UITableViewCell {

    var delegate: didTapOnCellDelegate?

    var currentVoto : Double = 6.0 {
        didSet {
            self.labelVoto.text = "\(currentVoto)"
        }
    }

    @IBOutlet var switcher_025: UIStepper!
    @IBOutlet var switcher_1: UIStepper!
    
    @IBOutlet var labelVoto: UILabel!
    
    @IBAction func switcher_act_025(_ sender: UIStepper) {
        self.didTapSwitcher()
    }
    
    @IBAction func switcher_act_1(_ sender: UIStepper) {
        self.didTapSwitcher()
    }

    func didTapSwitcher() {
        self.currentVoto = self.switcher_025.value + self.switcher_1.value
        delegate?.didTapForString?(string: "\(self.currentVoto)", info: "voto")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelVoto.text = "\(currentVoto)"
        self.switcher_025.minimumValue = 0.0
        self.switcher_025.maximumValue = 1
        self.switcher_1.minimumValue = 0
        self.switcher_1.maximumValue = 9
        self.switcher_025.value = 0
        self.switcher_1.value = 6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

