//
//  ViewController.swift
//  App_Foundations
//
//  Created by Maria Vitoria Soares Muniz on 22/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - PROPETIES
    
    @IBOutlet weak var TotalTime: UILabel!
    @IBOutlet var tableView: UITableView!
    var tasks = [Task]()
    
    func updateTotalTime() {
        var hour = 0
        var minute = 0
        
        for task in tasks {
            if (!task.isMarked) {
                hour = hour + Int(task.hour)!
                minute = minute + Int(task.minute)!
            }
        }
        
        if (minute >= 60) {
            hour = hour + minute/60
            minute = minute % 60
        }
        
        let hourText = String(hour).count <= 1 ? "0" + String(hour) + " h " : String(hour) + " h "
        
        let minuteText = String(minute).count <= 1 ? "0" + String(minute) + " min" : String(minute) + " min"
        
        TotalTime.text = hourText + minuteText
    }
    
    func orderTasks() {
        let sortedTasks = tasks.sorted(by: { $0.urgency * $0.complexity * $0.impact > $1.urgency * $1.complexity * $1.impact })
        
        tasks = sortedTasks
    }
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - PRIVATE FUNCTIONS
    
    private func setupUI() {
        self.title = "Tarefas" //nome da navigation bar da tela principal
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    //MARK: - ACTIONS
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? EntryViewController {
            if let task = sourceViewController.tempTask {
                tasks.append(task)
                updateTotalTime()
                orderTasks()
            }
        }
    }
    
//    @IBAction func unwindToRootViewControllerTaskView(segue: UIStoryboardSegue) {
//        if let sourceViewController = segue.source as? TaskViewController {
//            if let index = sourceViewController.taskIndex {
//                tasks.remove(at: index)
//                print("help me")
//            }
//        }
//    }
    
    //função responsável pela ação de adicionar uma tarefa
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title =  "Nova tarefa" //nome da navigation bar para adicionar uma tarefa
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - EXTENSIONS
//tela de edição da tarefa
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func checkButtonText(marked: Bool) -> String {
            if (marked) {
                return "Desmarcar"
            }
            
            return "Completar"
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let checkButton = UIAlertAction(title: checkButtonText(marked: self.tasks[indexPath.section].isMarked), style: .default) { (action) in
            tableView.deselectRow(at: indexPath, animated: true)
            
            guard let cell = tableView.cellForRow(at: indexPath) as? Cell else {return}
            
            self.tasks[indexPath.section].isMarked = !self.tasks[indexPath.section].isMarked
            
            cell.checkmarkImageView.image = self.tasks[indexPath.section].isMarked == true ? UIImage(named: "check") : UIImage(named: "uncheck")
            
            self.updateTotalTime()
        }
        
        let deleteButton = UIAlertAction(title: "Deletar", style: .destructive) { (action) in
            
            // Adicionar alerta
            let alertDelete = UIAlertController(title: "Deletar", message: "Tem certeza que você deseja deletar essa tarefa?", preferredStyle: .alert)
            
            // Configura botão SIM
            let yesButton = UIAlertAction(title: "Sim", style: .destructive) { (action) in
                
                // Remove a tarefa selecionada
                self.tasks.remove(at: indexPath[0])
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                self.updateTotalTime()
                self.orderTasks()
            }
            
            // Configura botão NÃO
            let noButton = UIAlertAction(title: "Não", style: .default, handler: nil)
            
            // Adiciona botões ao alerta
            alertDelete.addAction(yesButton)
            alertDelete.addAction(noButton)
            
            // Apresenta a tela do alerta
            self.present(alertDelete, animated: true, completion: nil)
            
        }
        
        // Configurar botão de editar
        let editButton = UIAlertAction(title: "Editar", style: .default) { (action) in
//            tableView.deselectRow(at: indexPath, animated: true)
            let vc = self.storyboard?.instantiateViewController(identifier: "task") as! EntryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let cancelButton = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
        }
        
        // Add button
        alert.addAction(checkButton)
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        // Show alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        // 1
//        let headerView = UIView()
//        // 2
//        headerView.backgroundColor = view.backgroundColor
//        // 3
//        return headerView
//    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.checkmarkImageView.image = tasks[indexPath.section].isMarked == true ? UIImage(named: "check") : UIImage(named: "uncheck")
        cell.taskLabel?.text = tasks[indexPath.section].name
        
        cell.hourLabel?.text = tasks[indexPath.section].hour + " h " + tasks[indexPath.section].minute + " min"
        
        
        //cell.detailTextLabel?.text = tasks[indexPath.section].description
        
        //cell.backgroundColor = UIColor.white
       // cell.layer.borderColor = UIColor.darkGray.cgColor
        //cell.layer.borderWidth = 1
       // cell.layer.cornerRadius = 8
       // cell.clipsToBounds = true
    
        
        return cell
    }
    

}

