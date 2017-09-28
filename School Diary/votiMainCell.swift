//
//  votiMainCell.swift
//  School Diary
//
//  Created by Carmine Cuofano on 21/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class votiMainCell: UITableViewCell {

    @IBOutlet var media: UILabel!
    @IBOutlet var votiCount: UILabel!
    @IBOutlet var materia: UILabel!
    @IBOutlet var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
