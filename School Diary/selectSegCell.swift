//
//  selectSegCell.swift
//  School Diary
//
//  Created by Carmine Cuofano on 30/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class selectSegCell: UITableViewCell {
    
    var delegate: didTapOnCellDelegate?

    @IBOutlet var segment: UISegmentedControl!

    @IBAction func segmentAct(_ sender: UISegmentedControl) {
        delegate?.didTapForString?(string: "\(sender.selectedSegmentIndex)", info: "selectedSegmentIndex")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
