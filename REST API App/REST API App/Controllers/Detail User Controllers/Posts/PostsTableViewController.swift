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
        tableView.register(UINib(nibName: PostTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.identifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: Functions
    
    func fetchPosts() {
        guard
            let user = user,
            let urlPosts = URL(string: ApiConstants.postsPath+"?user=\(user.id)")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
