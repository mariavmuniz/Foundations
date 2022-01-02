//
//  TaskViewController.swift
//  App_Foundations
//
//  Created by Maria Vitoria Soares Muniz on 22/11/21.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var taskIndex: Int?
    var task: String?
    var taskId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Deletar", style: .done, target: self, action: #selector(deleteTask))
    }

    @objc func deleteTask(for segue: UIStoryboardSegue, sender: Any?) {
        print("deletei a task")
        taskIndex = taskId
        navigationController?.popViewController(animated: true)
    }

}
