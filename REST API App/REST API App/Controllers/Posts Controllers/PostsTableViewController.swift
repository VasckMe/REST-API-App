//
//  PostsTableViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import UIKit

class PostsTableViewController: UITableViewController {

    // MARK: Properties
    var user: User?
    var posts: [Post] = []
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        fetchPosts()
        tableView.register(UINib(nibName: PostTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.identifier,
                for: indexPath) as? PostTableViewCell
        else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.refresh(model: post)
        return cell
    }

    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetailPostVC", sender: nil)
    }
    
    // MARK: - Functions
    
    func fetchPosts() {
        guard
            let user = user,
            let urlPosts = URL(string: ApiConstants.postsPath + "?userId=\(user.id)")
        else { return }
        
        let task = URLSession.shared.dataTask(with: urlPosts) { [weak self] data, response, error in
            if let error = error {
                print(error)
            }
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    self?.posts = try JSONDecoder().decode([Post].self, from: data)
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let detailPostVC = segue.destination as? DetailPostViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            detailPostVC.post = posts[indexPath.row]
            detailPostVC.user = user
        }
    }
}
