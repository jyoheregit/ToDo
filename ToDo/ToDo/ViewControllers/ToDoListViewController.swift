//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Joe on 01/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ToDoListViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private lazy var fetchedResultsController: NSFetchedResultsController<ToDo> = {
        let fetchedResultsController = CoreDataManager.shared.fetchedResultsController
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToDos()
        setupViews()
    }
    
    private func fetchToDos(){
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Fetch Request Error: \(fetchError), \(fetchError.localizedDescription)")
        }
        updateView()
    }
    
    private func setupViews() {
        self.title = Constants.ViewControllerTitle.ToDoList
        tableView.registerNibForCellClass(CellType.todo.getClass())
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    private func updateView() {
        var hasToDos = false
        if let todos = fetchedResultsController.fetchedObjects {
            hasToDos = todos.count > 0
        }
        tableView.isHidden = !hasToDos
        messageLabel.isHidden = hasToDos
        activityIndicatorView.stopAnimating()
    }
}

extension ToDoListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        updateView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
            case .insert:
                if let indexPath = newIndexPath {
                    tableView.insertRows(at: [indexPath], with: .fade)
                }
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            case .update:
                if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? ToDoCell {
                    let todo = fetchedResultsController.object(at: indexPath)
                    cell.todo = todo
                }
            case .move:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                if let newIndexPath = newIndexPath {
                    tableView.insertRows(at: [newIndexPath], with: .fade)
                }
        }
    }
}

extension ToDoListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let todoItems = fetchedResultsController.fetchedObjects else { return 0 }
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.cellReuseIdentifier(),
                                                       for: indexPath) as? ToDoCell else {
            fatalError("Unexpected Index Path")
        }
        let todo = fetchedResultsController.object(at: indexPath)
        cell.todo = todo
        return cell
    }
}

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let todo = self.fetchedResultsController.object(at: indexPath)
            guard let todoAddViewController = UIStoryboard.loadToDoAddViewController() else {
                fatalError("ToDoAddViewController instantiation from Storyboard Failed")
            }
            todoAddViewController.todo = todo
            let navigationViewController = UINavigationController(rootViewController: todoAddViewController)
            self.present(navigationViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
            let todo = self.fetchedResultsController.object(at: indexPath)

            let deleteAction = UITableViewRowAction(style: .destructive, title: Constants.Action.Delete) { (action, indexPath) in
                todo.delete()
                todo.managedObjectContext?.delete(todo)
                CoreDataManager.shared.saveContext()
            }
        
            let completeTitle = todo.completed ? Constants.Action.NotComplete : Constants.Action.Complete
            let completeAction = UITableViewRowAction(style: .normal, title: completeTitle){ (action, indexPath) in
                todo.complete(completed: !todo.completed)
                CoreDataManager.shared.saveContext()
            }
            completeAction.backgroundColor = UIColor.green
        
            return [completeAction, deleteAction]
    }
}
