//
//  ToDoCell.swift
//  ToDo
//
//  Created by Joe on 01/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var outerContainerView: UIView!
    @IBOutlet weak var colorContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reminderImageView: UIImageView!
    @IBOutlet weak var reminderLabel: UILabel!
    
    var todo : ToDo? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        titleLabel.text = todo?.title
        if let description = todo?.desc {
            descriptionLabel.text = description
        }
        else {
            descriptionLabel.text = nil
        }
        if let reminder = todo?.reminder {
            reminderLabel.text = reminder.string(with: .dateAndTime)
        }
        else {
            reminderLabel.text = Constants.Message.ReminderNotSet
        }
        if let completed = todo?.completed {
            colorContainerView.backgroundColor = completed ?  UIColor.green : UIColor.orange
        }
        else {
            colorContainerView.backgroundColor = UIColor.orange
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outerContainerView.layer.masksToBounds = false
        outerContainerView.layer.shadowOpacity = 0.8
        outerContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        outerContainerView.layer.shadowRadius = 5.0
        outerContainerView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

    
}
