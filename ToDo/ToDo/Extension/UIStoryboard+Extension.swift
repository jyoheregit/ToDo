//
//  UIStoryboard+Extension.swift
//  ToDo
//
//  Created by Joe on 06/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
}

fileprivate extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension UIStoryboard {
    class func loadToDoAddViewController() -> ToDoAddViewController? {
        return loadFromMain(Constants.SegueIdentifier.ToDoAdd) as? ToDoAddViewController
        
    }
}
