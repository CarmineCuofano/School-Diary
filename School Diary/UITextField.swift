//
//  UITextField.swift
//  School Diary
//
//  Created by Carmine Cuofano on 20/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

extension UITextField {
    func setToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.setItems([UIBarButtonItem(title: "Fine", style: .done, target: self, action: #selector(self.test2))], animated: true)
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
    @objc private func test2 () {
        self.resignFirstResponder()
    }
}
