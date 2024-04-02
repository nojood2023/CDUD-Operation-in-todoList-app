//
//  ViewController.swift
//  todo list app
//
//  Created by Nojood Aljuaid  on 23/09/1445 AH.
//

import UIKit

class TodoViewController : UIViewController {
    var todosArray = [
        Todo(title: "Swift class", image: UIImage(named: "coding")!, details: "Go to the academy to learn Swift language,develop ios application,learn interface design,and how to create projects with a professional team every morning"),
        Todo(title: "Go for run", image: UIImage(named: "run")!, details: "run daily for half an hour to achieve a toned body,increase bone density,and strengthen it"),
        Todo(title: "read a book", image: UIImage(named: "book"), details: "read a new book every month to develop myself")
    ]
    @IBOutlet weak var todosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        todosTableView.dataSource = self
        todosTableView.delegate = self
        //ADD A NEW TODO
        NotificationCenter.default.addObserver(self, selector: #selector(addNewTodo), name: NSNotification.Name("addNewTodo"), object: nil)
        //EDIT TODO
        NotificationCenter.default.addObserver(self, selector: #selector(editedTodo), name: NSNotification.Name("editedTodo"), object: nil)
        //DELETE TODO
        NotificationCenter.default.addObserver(self, selector: #selector(deletedTodo), name: NSNotification.Name("deletedTodo"), object: nil)
    }
    @objc func deletedTodo(notification : Notification) {
        if let index = notification.userInfo?["deletedTodo"] as? Int {
            todosArray.remove(at: index)
            todosTableView.reloadData()
        }
    }
    
    @objc func editedTodo (notification : Notification) {
        if   let todo = notification.userInfo?["editedTodo"] as? Todo {
            if let index = notification.userInfo?["editedIndex"] as? Int {
                todosArray[index] = todo
                todosTableView.reloadData()
            }
        }
        
    }
    
    @objc func addNewTodo (notification : Notification) {
        let todo = notification.userInfo?["addNewTodo"] as! Todo
        todosArray.append(todo)
        todosTableView.reloadData()
    }
    
    

}

extension TodoViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TodoTableViewCell
        var todos = todosArray[indexPath.row]
        cell.titleTodo.text = todos.title
        if todos.image != nil {
            cell.imageTodo.image = todos.image }
        else {
            cell.imageTodo.image = UIImage(named: "run")!
        }
        cell.imageTodo.layer.cornerRadius = cell.imageTodo.frame.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "second vc") as? detailsViewController
        var todos = todosArray[indexPath.row]
        if let viewController = vc {
            viewController.todo = todos
            viewController.index = indexPath.row
            navigationController?.pushViewController(viewController, animated: true)
        }
       
        }
    
}
