//
//  CommentTableViewCell.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var bodyTextView: UITextView!

    // MARK: Properties
    static let identifier = "CommentTableViewCell"
    
    // MARK: Functions
    func refrehs(model: Comment) {
        emailLabel.text = model.email
        nameLabel.text = model.name
        bodyTextView.text = model.body
    }
}
