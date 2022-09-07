//
//  UsersTableViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 30.08.22.
//

import UIKit

class UsersTableViewController: UITableViewController {

    // MARK: - Properties
    
    private var users: [User] = []
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil),
                           forCellReuseIdentifier: UserTableViewCell.identifier)
    }

    // MARK: - Functions
    
    func fetchUsersData() {
        guard let url = URL(string: ApiConstants.usersPath) else { return }
        NetworkService.getData(url: url) {[weak self] result, error in
            if let data = result {
                do {
                    self?.users = try JSONDecoder().decode([User].self, from: data)
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UserTableViewCell.identifier,
                for: indexPath) as? UserTableViewCell
        else {
            return UITableViewCell()
        }

        let user = users[indexPath.row]
        cell.refresh(model: user)

        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "GoToDetailUserVC", sender: user)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let detailUserVC = segue.destination as? DetailUserViewController,
            let user = sender as? User,
            segue.identifier == "GoToDetailUserVC"
        {
            detailUserVC.user = user
        }
    }
    

}
