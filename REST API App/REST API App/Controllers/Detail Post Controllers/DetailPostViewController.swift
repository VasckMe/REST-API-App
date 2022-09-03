//
//  DetailPostViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import UIKit

class DetailPostViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postTextView: UITextView!
    
    // MARK: - Properties
    var post: Post?
    var users: [User] = []
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    // MARK: - Functions

    private func setupUI() {
        postTextView.layer.cornerRadius = 15
        postTextView.layer.borderColor = UIColor.gray.cgColor
        postTextView.layer.borderWidth = 2
        
        guard let post = post else { return }
        
        postTextView.text = post.body
        postTitleLabel.text = post.title
        userLabel.text = users[post.userId].username
    }
    
    private func fetchUsers() {
        guard let url = URL(string: ApiConstants.usersPath) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, response, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    self?.users = try JSONDecoder().decode([User].self, from: data)
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.main.async {
                self?.setupUI()
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
