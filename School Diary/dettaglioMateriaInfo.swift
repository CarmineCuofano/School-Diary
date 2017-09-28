
//
//  dettaglioMateriaInfo.swift
//  School Diary
//
//  Created by Carmine Cuofano on 20/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class dettaglioMateriaInfo: UITableViewCell, UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    var myIndexPath: IndexPath!
    
    var delegate: didTapOnCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate = self
        self.textView.setToolbar()
        self.setMode()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.textView.textColor = .black
        (self.superview as? UITableView)?.scrollToRow(at: self.myIndexPath, at: .middle, animated: true)
        return true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.delegate?.didTapForString?(string: textView.text, info: "info")
        return true
    }


    func setMode() {
        textView.textColor = textView.text.isEmpty || textView.text == "Aggiungi una descrizione" ? .lightGray : .black
        textView.text = textView.text.isEmpty ? "Aggiungi una descrizione" : textView.text
    }

}
