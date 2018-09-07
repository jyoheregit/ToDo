//
//  CoreDataManager.swift
//  ToDo
//
//  Created by Joe on 01/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
 
    init() {
        setupNotifications()
    }
   
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "ToDo")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return persistentContainer
    }()
    
    var fetchedResultsController: NSFetchedResultsController<ToDo> {
        
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "completed", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    private func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(forName: Notification.Name.UIApplicationWillTerminate, object: nil, queue: OperationQueue.main) { _ in
            self.saveContext()
        }
        notificationCenter.addObserver(forName: Notification.Name.UIApplicationDidEnterBackground, object: nil, queue: OperationQueue.main) { _ in
            self.saveContext()
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
