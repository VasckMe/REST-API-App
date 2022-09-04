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
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var commentsTableView: UITableView!
    
    // MARK: - Properties
    var post: Post?
    var user: User?
    var comments: [Comment] = []
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        commentsTableView.register(
            UINib(nibName: CommentTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CommentTableViewCell.identifier)
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        fetchComments()
    }
    
    // MARK: - Functions

    private func setupUI() {
        postTextView.layer.cornerRadius = 15
        postTextView.layer.borderColor = UIColor.gray.cgColor
        postTextView.layer.borderWidth = 2
        
        guard let post = post else { return }
        
        postTextView.text = post.body
        postTitleLabel.text = post.title
        userLabel.text = user?.username
        commentsLabel.text = "Comments: " + String(comments.count)
    }
    
    private func fetchComments() {
        guard
            let post = post,
            let urlComments = URL(string: ApiConstants.commentsPath + "?postId=\(post.id)")
        else {
            return
        }
        
        let taskComment = URLSession.shared.dataTask(
            with: urlComments)
        { [weak self] data, _, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    self?.comments = try JSONDecoder().decode([Comment].self, from: data)
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.main.async {
                self?.setupUI()
                self?.commentsTableView.reloadData()
            }
        }
        taskComment.resume()
    }
}

extension DetailPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CommentTableViewCell.identifier,
                for: indexPath) as? CommentTableViewCell
        else {
            return UITableViewCell()
        }
        let comment = comments[indexPath.row]
        cell.refrehs(model: comment)
        return cell
    }
}
