//
//  ViewController.swift
//  UITableViewWithRealm
//
//  Created by Aaron on 4/11/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var notificationToken: NotificationToken?
    var results: Results<Task>!
    @IBOutlet weak var tableViewTasks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.reloadResults()
    }

    func setupUI() {
        self.title = "My tasks"
        self.tableViewTasks.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    func reloadResults() {
        let realm = try! Realm()
        self.results = realm.objects(Task.self)
        self.tableViewTasks.reloadData()
    }

    @objc func add() {
        let alertController = UIAlertController(title: "New Task", message: "Enter Task Name", preferredStyle: .alert)
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Task Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField.text , !text.isEmpty else { return }
            
            self.writeInRealm(withTask: Task(value: ["text": text]))
            self.reloadResults()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    func writeInRealm(withTask task: Task) {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
            print("Realm write error")
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row].text
        cell.alpha = results[indexPath.row].isCompleted ? 0.5 : 1.0
        return cell
    }
}
