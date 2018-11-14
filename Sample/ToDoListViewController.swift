//
//  ViewController.swift
//  Sample
//
//  Created by Morteza on 11/14/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var todos : [ToDoModel] = []{
    didSet{
      tableView.reloadData()
    }
  }
  private var toDoServiceCore = ToDoListServiceCore.sharedInstance

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(ToDoTableViewCell.self)
    toDoServiceCore.getToDoList()
    toDoServiceCore.toDoListDelegate = self
  }


}

extension ToDoListViewController :UITableViewDataSource,UITableViewDelegate{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ToDoTableViewCell
    let toDoObj = todos[indexPath.row]
    cell.fillData(todo: toDoObj)
    
    return cell
  }
}

extension ToDoListViewController : ToDoListProtocol{
  
  func loadAllToDo(albums: [ToDoModel]) {
    
    todos = albums
  }
  
  func loadAllToDoWithError(error: ServiceError) {
    
    // Show some Error
  }
  
  
}

