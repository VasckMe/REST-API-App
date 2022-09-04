//
//  TodosTableViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

class TodosTableViewController: UITableViewController {

    var user: User?
    var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todos"
        tableView.register(
            UINib(nibName: TodosTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: TodosTableViewCell.identifier
        )
        fetchTodos()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodosTableViewCell.identifier,
                for: indexPath) as? TodosTableViewCell
        else {
            return UITableViewCell()
        }
        let todo = todos[indexPath.row]
        cell.refresh(model: todo)

        return cell
    }

    private func fetchTodos() {
        guard
            let user = user,
            let url = URL(string: ApiConstants.todosPath + "?userId=\(user.id)")
        else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
            }
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    self?.todos = try JSONDecoder().decode([Todo].self, from: data)
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }
}
