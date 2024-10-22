//
//  ViewController.swift
//  MyFirstAPP
//
//  Created by Arafath Hossain on 19/10/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    var items = [String]()
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        title = "To do list items"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "New item", message: "Add new item", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter something..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    print(text)
                    DispatchQueue.main.async {
                        self.items.append(text)
                        self.table.reloadData()
                    }
                }
            }
        }))
        present(alert, animated: true)
    }


}

