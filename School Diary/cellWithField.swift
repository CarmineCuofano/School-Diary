//
//  cellWithField.swift
//  School Diary
//
//  Created by Carmine Cuofano on 20/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class cellWithField: UITableViewCell, UITextFieldDelegate{

    var delegate: didTapOnCellDelegate?
    var myIndexPath: IndexPath!
    
    @IBOutlet var field: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.field.delegate = self
        self.field.setToolbar()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.field.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        (self.superview as? UITableView)?.scrollToRow(at: self.myIndexPath, at: .middle, animated: true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.passInfoToSuperview()
        return true
    }

    func passInfoToSuperview() {
        switch tag {
        case 0: delegate?.didTapForString?(string: self.field.text, info: "materia")
        case 1: delegate?.didTapForString?(string: self.field.text, info: "prof")
        case 2: delegate?.didTapForString?(string: self.field.text, info: "aula")
        default: delegate?.didTapForString?(string: self.field.text, info: "goal")
        }
    }

}
