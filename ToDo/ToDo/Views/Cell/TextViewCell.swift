//
//  TextViewCell.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import UIKit

class TextViewCell: BaseCell {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate = self
    }

    override func setTitle(title: String) {
        headerTitle.text = title
    }
    
    override func setTextValue(text: String?){
        textView.textColor = UIColor.black
        textView.text = text
    }
    
    override func setKeyboardType(type: UIKeyboardType) {
        textView.keyboardType = type
    }
}

extension TextViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textChangedBlock?(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

