//
//  CoreDataManagerTest.swift
//  ToDoTests
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import XCTest
import CoreData

@testable import ToDo

class CoreDataManagerTest: XCTestCase {
    
    var sut: MockCoreDataManager = MockCoreDataManager()
    
    override func setUp() {
        super.setUp()
    }
    
    func fetchAll() -> [ToDo] {
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "completed", ascending: true),
                                        NSSortDescriptor(key: "createdAt", ascending: false)]
        
        do {
            return try sut.managedObjectContext().fetch(fetchRequest)
        }
        catch {
            fatalError("Failed to fetch tasks: \(error)")
        }
    }
    
    func testIsEmpty() {
        let todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 0)
    }
    
    func testInsertToDo() {
        
        let todo = ToDo(context : sut.managedObjectContext())
            
        todo.title = "Task 1"
        todo.desc = "Task 1 to be completed"
        let date = Date()
        todo.createdAt = date
        todo.reminder = date
        todo.completed = false
        
        sut.saveContext()
        
        let todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 1)
        XCTAssertEqual(todoItems[0].title, "Task 1")
        XCTAssertEqual(todoItems[0].desc, "Task 1 to be completed")
        XCTAssertEqual(todoItems[0].createdAt, date)
        XCTAssertEqual(todoItems[0].reminder, date)
        XCTAssertEqual(todoItems[0].completed, false)
    }
    
    func testMultipleInserts() {
        
        var todo = ToDo(context : sut.managedObjectContext())
        
        todo.title = "Task 1"
        todo.desc = "Task 1 to be completed"
        let date = Date()
        todo.createdAt = date
        todo.reminder = date
        todo.completed = false
        
        todo = ToDo(context : sut.managedObjectContext())
        
        todo.title = "Task 2"
        todo.desc = "Task 2 to be completed"
        let anotherDate = Date()
        todo.createdAt = anotherDate
        todo.reminder = anotherDate
        todo.completed = false
        
        sut.saveContext()
        
        let todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 2)
        XCTAssertEqual(todoItems[0].title, "Task 2")
        XCTAssertEqual(todoItems[0].desc, "Task 2 to be completed")
        XCTAssertEqual(todoItems[0].createdAt, anotherDate)
        XCTAssertEqual(todoItems[0].reminder, anotherDate)
        XCTAssertEqual(todoItems[0].completed, false)
        
        XCTAssertEqual(todoItems[1].title, "Task 1")
        XCTAssertEqual(todoItems[1].desc, "Task 1 to be completed")
        XCTAssertEqual(todoItems[1].createdAt, date)
        XCTAssertEqual(todoItems[1].reminder, date)
        XCTAssertEqual(todoItems[1].completed, false)
    }
    
    func testToDoDescriptionNil(){
        
        let todo = ToDo(context : sut.managedObjectContext())
        
        todo.title = "Task 1"
        let date = Date()
        todo.createdAt = date
        todo.reminder = date
        todo.completed = false
        
        sut.saveContext()
        
        let todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 1)
        XCTAssertEqual(todoItems[0].title, "Task 1")
        XCTAssertEqual(todoItems[0].createdAt, date)
        XCTAssertEqual(todoItems[0].reminder, date)
        XCTAssertEqual(todoItems[0].completed, false)
        
        XCTAssertEqual(todoItems[0].desc, nil)
    }
    
    func testToDoReminderNil(){
        
        let todo = ToDo(context : sut.managedObjectContext())
        
        todo.title = "Task 1"
        let date = Date()
        todo.createdAt = date
        todo.completed = false
        
        sut.saveContext()
        
        let todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 1)
        XCTAssertEqual(todoItems[0].title, "Task 1")
        XCTAssertEqual(todoItems[0].desc, nil)
        XCTAssertEqual(todoItems[0].createdAt, date)
        XCTAssertEqual(todoItems[0].completed, false)
        
        XCTAssertEqual(todoItems[0].reminder, nil)
    }
    
    func testToDoUpdate(){
        
        let todo = ToDo(context : sut.managedObjectContext())
        
        todo.title = "Task 1"
        todo.desc = "Task 1 to be completed"
        let date = Date()
        todo.createdAt = date
        todo.reminder = date
        todo.completed = false
        
        sut.saveContext()
        
        var todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 1)
        XCTAssertEqual(todoItems[0].title, "Task 1")
        XCTAssertEqual(todoItems[0].desc, "Task 1 to be completed")
        XCTAssertEqual(todoItems[0].createdAt, date)
        XCTAssertEqual(todoItems[0].reminder, date)
        XCTAssertEqual(todoItems[0].completed, false)
        
        todo.title = "Updated Task 1"
        todo.desc = "Updated Task 1 to be completed"
        let updatedDate = Date()
        todo.reminder = updatedDate
        todo.completed = true
        
        sut.saveContext()
        
        todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 1)
        XCTAssertEqual(todoItems[0].title, "Updated Task 1")
        XCTAssertEqual(todoItems[0].desc, "Updated Task 1 to be completed")
        XCTAssertEqual(todoItems[0].createdAt, date)
        XCTAssertEqual(todoItems[0].reminder, updatedDate)
        XCTAssertEqual(todoItems[0].completed, true)
    }
    
    func testToDoDelete() {
        
        let todo = ToDo(context : sut.managedObjectContext())
        
        todo.title = "Task 1"
        todo.desc = "Task 1 to be completed"
        let date = Date()
        todo.createdAt = date
        todo.reminder = date
        todo.completed = false
        
        sut.saveContext()
        
        var todoItems = fetchAll()
        XCTAssertEqual(todoItems.count, 1)
        XCTAssertEqual(todoItems[0].title, "Task 1")
        XCTAssertEqual(todoItems[0].desc, "Task 1 to be completed")
        XCTAssertEqual(todoItems[0].createdAt, date)
        XCTAssertEqual(todoItems[0].reminder, date)
        XCTAssertEqual(todoItems[0].completed, false)
        
        sut.managedObjectContext().delete(todo)
        todoItems = fetchAll()
        
        XCTAssertEqual(todoItems.count, 0)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
