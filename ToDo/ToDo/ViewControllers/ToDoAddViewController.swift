//
//  ToDoAddViewController.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import UIKit

class ToDoAddViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var todo : ToDo?
    
    var titleText : String? {
        didSet {
            self.setSaveButtonState()
        }
    }
    
    var descriptionText : String?
    var reminderDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSaveButtonState()
        cellTypes = [.text, .textView, .dateTime]
        setupViews()
    }
    
    func setupViews() {
        
        self.title = (todo != nil) ? Constants.ViewControllerTitle.ToDoEdit : Constants.ViewControllerTitle.ToDoAdd
        
        for type in cellTypes {
            tableView.registerNibForCellClass(type.getClass())
        }
        self.titleText = todo?.title
        self.descriptionText = todo?.desc
        self.reminderDate = todo?.reminder
    }
    
    func setSaveButtonState() {
        guard let titleText = titleText else{
            saveButton.isEnabled = false
            return;
        }
        saveButton.isEnabled = (titleText.count > 0)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        
        if todo == nil {
            todo = ToDo(context: managedObjectContext)
            todo?.createdAt = Date()
        }
        
        todo?.title = titleText
        todo?.desc = descriptionText
        todo?.reminder = reminderDate
        todo?.completed = todo?.completed ?? false
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func updateCell(cell: BaseCell, indexPath: IndexPath) {
        
        let cellType = cellTypes[indexPath.row]
        
        switch cellType {
            case .text:
                guard let cell = cell as? TextCell else{
                    fatalError("Cell is not of type TextCell")
                }
                cell.setTextValue(text: todo?.title)
                cell.textChangedBlock = { (text) in
                    self.titleText = text
                }
            case .textView:
                guard let cell = cell as? TextViewCell else{
                    fatalError("Cell is not of type TextViewCell")
                }
                cell.setTextValue(text: todo?.desc)
                cell.textChangedBlock = { (text) in
                    self.descriptionText = text
                }
            case .dateTime:
                guard let cell = cell as? DateTimePickerCell else{
                    fatalError("Cell is not of type DateTimePickerCell")
                }
                cell.setDateValue(date: todo?.reminder)
                cell.dateTimeChangedBlock = { (date) in
                    self.reminderDate = date
                }
            default :
                super.updateCell(cell: cell, indexPath: indexPath)
        }
    }
}


