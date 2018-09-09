//
//  TextCell.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import UIKit

class TextCell: BaseCell {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textField.delegate = self
    }

    override func setTitle(title: String) {
        headerTitle.text = title
    }
    
    override func setPlaceholder(placeholder: String) {
        textField.placeholder = placeholder
    }
    
    override func setKeyboardType(type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    override func setTextValue(text: String?){
        textField.text = text
    }

    @IBAction func textDidChange(textField: UITextField){
        if let txt = textField.text{
            textChangedBlock?(txt)
        }
    }
}

extension TextCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

    

