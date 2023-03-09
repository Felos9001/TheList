//
//  ViewController.swift
//  THELIST
//
//  Created by Nicolas Sedano on 3/3/23.
// Credit: IOS Academy

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var t: UITableView!
    var lists = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ToDoList"
        t.delegate = self
        t.dataSource = self
        if UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count1")
        }
        updateList()
    }
    
    func updateList() {
        lists.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for i in 0..<count {
            if let list = UserDefaults().value(forKey: "list_\(i+1)") as? String {
                lists.append(list)
            }
        }
        
        t.reloadData()
    }
    
    @IBAction func NewList() {
        let viewC = storyboard?.instantiateViewController(withIdentifier: "start") as! EnterController
        viewC.title = "new list"
        viewC.update = {
            DispatchQueue.main.async {
                    self.updateList()
            }
        }
        navigationController?.pushViewController(viewC, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewC = storyboard?.instantiateViewController(withIdentifier: "list") as! ListViewController
        viewC.title = "new list"
        viewC.list = lists[indexPath.row]
            navigationController?.pushViewController(viewC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        c.textLabel?.text = lists[indexPath.row]
        return c
    }
}
