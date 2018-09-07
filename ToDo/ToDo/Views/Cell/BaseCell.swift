//
//  BaseCell.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    
    var type: CellType?
    var textChangedBlock: ((String) -> Void)?
    var dateTimeChangedBlock : ((Date?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(title: String, placeholder: String, keyboardType: UIKeyboardType){
        setTitle(title: title)
        setPlaceholder(placeholder:  placeholder)
        setKeyboardType(type: keyboardType)
    }
    
    func setTitle(title: String){}
    func setPlaceholder(placeholder: String){}
    func setKeyboardType(type: UIKeyboardType){}
    func setTextValue(text: String?){}
    func setDateValue(date: Date?){}
}
