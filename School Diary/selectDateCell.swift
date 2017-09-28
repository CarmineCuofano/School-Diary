//
//  selectDateCell.swift
//  School Diary
//
//  Created by Carmine Cuofano on 30/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class selectDateCell: UITableViewCell {
    
    var delegate: didTapOnCellDelegate?

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var selectDate: UIDatePicker!

    @IBAction func select_date_act(_ sender: UIDatePicker) {
        self.dateLabel.text = sender.date.description
        delegate?.didTapForString?(string: sender.date.description, info: "didTapForDate")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dateLabel.text = self.selectDate.date.description
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
