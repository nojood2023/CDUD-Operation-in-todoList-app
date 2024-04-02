//
//  detailsViewController.swift
//  todo list app
//
//  Created by Nojood Aljuaid  on 23/09/1445 AH.
//

import UIKit

class detailsViewController: UIViewController {
    var todo : Todo!
    var index : Int!
    @IBOutlet weak var imageTableView: UIImageView!
    @IBOutlet weak var titleViewTable: UILabel!
    @IBOutlet weak var detailsTableView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todo.image != nil {
            imageTableView.image = todo.image }
        else {
            imageTableView.image = UIImage(named: "run")!
            }
        setup ()
        
        NotificationCenter.default.addObserver(self, selector: #selector(editedTodo), name: NSNotification.Name("editedTodo"), object: nil)
        
    }
    @objc func editedTodo (notification : Notification) {
        if   let todo = notification.userInfo?["editedTodo"] as? Todo {
               
            self.todo = todo
            setup()
        }
        
    }
    
    func setup() {
        titleViewTable.text = todo.title
        detailsTableView.text = todo.details
    }
   
    @IBAction func editedClickedButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "add") as? AddNewTodoViewController
        
        if let viewCont = vc {
            viewCont.isCreation = false
            viewCont.editedTodoIndex = index
            viewCont.isEdit = todo
            navigationController?.pushViewController(viewCont, animated: true)
            
            
            
        }
    }
    
    
    @IBAction func deletedButtonClicked(_ sender: Any) {
        var confirmAlert = UIAlertController(title: "Remove (task)?", message: "Are you sure you want to delete the task", preferredStyle: UIAlertController.Style.alert)
        var confirAction = UIAlertAction(title: "yes,sure", style: UIAlertAction.Style.destructive) { _ in
            NotificationCenter.default.post(name: NSNotification.Name("deletedTodo"), object: nil, userInfo: ["deletedTodo" : self.index])
            
            var alert = UIAlertController(title: "deleted done", message: "the task was deleted successfuly", preferredStyle: UIAlertController.Style.alert)
            var alertAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler : {_ in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true , completion: nil)
            alert.addAction(alertAction)
        }
        var cancelAction = UIAlertAction(title: "cancel", style: .default, handler: nil)
        confirmAlert.addAction(confirAction)
        confirmAlert.addAction(cancelAction)
        present(confirmAlert, animated: true)
        
          }
    
}
