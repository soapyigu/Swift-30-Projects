//
//  ViewController.swift
//  ToDo
//
//  Created by Song Zixin on 7/26/17.
//  Copyright © 2017 Silk Song. All rights reserved.
//

import UIKit


class ToDoListViewController: UITableViewController, DetailToDoViewControllerDelegate {
    
    let identifier = "TodoCell"
    var todoList: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        let disney = Todo(title: "Go to Disney", date: dateFromString("2014-10-20")!, imageName: "child-selected")
        todoList.append(disney)

        let shopping = Todo(title: "Cicso Shopping", date: dateFromString("2014-10-28")!, imageName: "shopping-cart-selected")
        todoList.append(shopping)

        let phone = Todo(title: "Phone to Jobs", date: dateFromString("2014-10-30")!, imageName: "phone-selected")
        todoList.append(phone)

        let europe = Todo(title: "Plan to Europe", date: dateFromString("2014-10-31")!, imageName: "travel-selected")
        todoList.append(europe)
    }
    
    //MARK: TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        var numbOfSections = 0
        if todoList.count != 0 {
            numbOfSections = 1
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
            
        } else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No data is currently available"
            noDataLabel.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 20.0)
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numbOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel!.text = todoList[indexPath.row].title
        cell.imageView!.image = UIImage(named: todoList[indexPath.row].imageName)
        cell.detailTextLabel!.text = stringFromDate(todoList[indexPath.row].date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            if todoList.count == 0 {
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                return
            }
            tableView.deleteRows(at: [indexPath] , with: .bottom)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todoList[sourceIndexPath.row]
        todoList.remove(at: sourceIndexPath.row)
        todoList.insert(todo, at: destinationIndexPath.row)
    }
    
    
    //MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    //MARK: DetailToDoViewControllerDelegate
    
    func detailToDoViewController(_ controller: DetailToDoViewController, addNewTodo todo: Todo) {
        todoList.append(todo)
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func detailToDoViewController(_ controller: DetailToDoViewController, editTodo: Todo) {
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let navicontroller = segue.destination as! UINavigationController
            let controller = navicontroller.topViewController as! DetailToDoViewController
            controller.delegate = self
        } else if segue.identifier == "EditDetail" {
            let navicontroller = segue.destination as! UINavigationController
            let controller = navicontroller.topViewController as! DetailToDoViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.editTodo = todoList[indexPath.row]
            }
        }
    }
}

