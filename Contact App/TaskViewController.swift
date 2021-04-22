//
//  TaskViewController.swift
//  Contact App
//
//  Created by Utshab on 2021-04-21.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var task: String?
    var index = 0
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
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
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
    

}
