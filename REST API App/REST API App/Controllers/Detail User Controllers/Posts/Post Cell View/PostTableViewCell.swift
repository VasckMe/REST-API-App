//
//  PostTableViewCell.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postBodyLabel: UILabel!
    
    // MARK: Properties
    static let identifier = "PostTableViewCell"

    // MARK: Functions
    func refresh(model: Post) {
        postTitleLabel.text = model.title
        postBodyLabel.text = model.body
    }
}
