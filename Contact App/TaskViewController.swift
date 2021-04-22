//
//  TaskViewController.swift
//  Contact App
//
//  Created by Utshab on 2021-04-21.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var numberlabel: UILabel!
    
    var task: String?
    var index = 0
    var number: String?
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Name: \(task!)"
        numberlabel.text = "Phone Number: \(number!)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Delete", style: .done, target: self, action:#selector(deleteTask))

        // Do any additional setup after loading the view.
    }
    
    @objc func deleteTask(){
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
//        collectionView.indexPathsForSelectedItems
        let newCount = count - 1
        let current = index + 1
        UserDefaults().setValue(newCount, forKey: "count")
        UserDefaults().setValue(nil, forKey: "task_\(current)")
        UserDefaults().set(nil, forKey: "number_\(current)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
    

}
