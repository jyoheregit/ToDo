//
//  BaseViewController.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var cellTypes = [CellType]()
    func updateCell(cell: BaseCell, indexPath: IndexPath){}
}

extension BaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellTypes[indexPath.row]
        let cellClass = cellType.getClass()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellClass.cellReuseIdentifier(),
                                                       for: indexPath) as? BaseCell else {
            fatalError("Unexpected Index Path")
        }
        cell.set(title: cellType.headerTitle(), placeholder: cellType.placeholder(), keyboardType: cellType.keyboardType())
        updateCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

extension BaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = cellTypes[indexPath.row]
        return cell.height()
    }
}
