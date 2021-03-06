//
//  ViewController.swift
//  Contact App
//
//  Created by Utshab on 2021-04-21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    
    var tasks = [String]()
    var numbers = [String]()
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        // setup
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // get all current saved tasks
    }
    func updateTasks(){
        
        tasks.removeAll()
        numbers.removeAll()
         
       guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count {
            
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
                tasks.append(task)
            }
            if let number = UserDefaults().value(forKey: "number_\(x+1)") as? String{
                numbers.append(number)
            }
            
            
        }
        tableView.reloadData()
        
    }
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "Add Contact"
        
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
    extension ViewController: UITableViewDelegate{
        func tableView(_ tableView:UITableView,
                       didSelectRowAt indexPath: IndexPath){
            tableView.deselectRow(at: indexPath, animated: true)
            
            let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
            vc.title = tasks[indexPath.row]
            vc.index = indexPath.row
            vc.task = tasks[indexPath.row]
            vc.number = numbers[indexPath.row]
            vc.update = {
                DispatchQueue.main.async {
                    self.updateTasks()
                }
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}






