//
//  AddNewTodoViewController.swift
//  todo list app
//
//  Created by Nojood Aljuaid  on 23/09/1445 AH.
//

import UIKit

class AddNewTodoViewController: UIViewController {

    var isCreation = true 
    var isEdit : Todo?
    var editedTodoIndex : Int?
    @IBOutlet weak var addTitleTodo: UITextField!
    
    @IBOutlet weak var mainLable: UIView!
    
    @IBOutlet weak var mainLable2: UILabel!
    @IBOutlet weak var editedTodo: UIButton!
    @IBOutlet weak var addDetailsTodo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isCreation == false {
            editedTodo.setTitle("edit", for: .normal)
            mainLable2.text = "Edit task"
            
        }
        if let todo = isEdit {
            addTitleTodo.text = todo.title
            addDetailsTodo.text = todo.details
        }
      
    }
    

    @IBAction func addClickedButton(_ sender: Any) {
        
        if isCreation  {
            let todo = Todo(title: addTitleTodo.text!, details: addDetailsTodo.text!)
            NotificationCenter.default.post(name: NSNotification.Name("addNewTodo"), object: nil, userInfo: ["addNewTodo" : todo])
            
            var alert = UIAlertController(title: "added done", message: "the task was added successfuly", preferredStyle: UIAlertController.Style.alert)
            var alertAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler : {_ in
                self.tabBarController?.selectedIndex = 0
                self.addTitleTodo.text = ""
                self.addDetailsTodo.text = ""
            })
            present(alert, animated: true , completion: nil)
            alert.addAction(alertAction)
            
        }
    
    
    else {
        let todo = Todo(title: addTitleTodo.text!, details: addDetailsTodo.text!)
        NotificationCenter.default.post(name: NSNotification.Name("editedTodo"), object: nil, userInfo: ["editedTodo" : todo , "editedIndex" : editedTodoIndex ])
        
        var alert = UIAlertController(title: "edited done", message: "the task was adited successfuly", preferredStyle: UIAlertController.Style.alert)
        var alertAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler : {_ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true , completion: nil)
        alert.addAction(alertAction)    }
}
}
