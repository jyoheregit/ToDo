//
//  MockCoreDataManager.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import CoreData

@testable import ToDo

class MockCoreDataManager: CoreDataManager {
    
    override func managedObjectContext() -> NSManagedObjectContext {
        return managedObjectContextLazy
    }
    
    lazy var managedObjectContextLazy: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator?.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        }
        catch {
            coordinator = nil
        }
        return coordinator
    }()
}
