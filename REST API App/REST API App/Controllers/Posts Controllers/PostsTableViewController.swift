//
//  PostsTableViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import UIKit
// MARK: - Protocols
protocol UpdatePostsData {
    func update()
}

// MARK: - Class
final class PostsTableViewController: UITableViewController {

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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let id = posts[indexPath.row].id
            let url = ApiConstants.postsPath+"/\(id)"
            NetworkService.removeData(
                url: url) {[weak self] result, error in
                    if result != nil {
                        self?.posts.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        tableView.reloadData()
                    } else {
                        print(error!)
                    }
                }
        default:
            break
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetailPostVC", sender: nil)
    }
    
    // MARK: - Functions
    
    private func fetchPosts() {
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
        } else if let newPostVC = segue.destination as? NewPostViewController {
            newPostVC.userId = user?.id
            newPostVC.delegate = self
        }
    }
}

// MARK: - Extensions
extension PostsTableViewController: UpdatePostsData {
    func update() {
        fetchPosts()
    }
}
