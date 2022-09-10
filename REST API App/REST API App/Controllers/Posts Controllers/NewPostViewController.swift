//
//  NewPostViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 6.09.22.
//

import UIKit
import Alamofire
import SwiftyJSON

final class NewPostViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var postTitleLabel: UITextField!
    @IBOutlet private weak var postBodyTextView: UITextView!
    @IBOutlet private weak var titleErrorLabel: UILabel!
    @IBOutlet private weak var bodyErrorLabel: UILabel!
    @IBOutlet private weak var savePostButton: UIButton!
    
    // MARK: - Properties
    var isTitleRight = false {
        didSet {
            checkPostButton()
        }
    }
    var isBodyRight = false {
        didSet {
            checkPostButton()
        }
    }
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super .viewDidLoad()
        postBodyTextView.delegate = self
    }
    
    // MARK: - Properties
    var userId: Int?
    
    // MARK: Delegates
    var delegate: UpdatePostsData?
    
    // MARK: - IBActions
    @IBAction private func savePostAction() {
        guard
            let url = ApiConstants.postsURL,
            let userId = userId,
            let title = postTitleLabel.text,
            let body = postBodyTextView.text else { return }
        
        let model: Parameters = [
            "userId":userId,
            "title":title,
            "body":body]
        
        NetworkService.postData(url: url, parameters: model) { result, error in
            if result != nil {
                if let delegate = self.delegate {
                    delegate.update()
                }
                self.navigationController?.popViewController(animated: true)
            } else {
                print(error!)
            }
        }
    }
    
    @IBAction private func titleAction() {
        checkTitleForError()
    }
    
    // MARK: - Private functions
    private func checkPostButton() {
        savePostButton.isEnabled = isTitleRight && isBodyRight
    }
    private func checkTitleForError() {
        if let title = postTitleLabel.text {
            isTitleRight = !title.isEmpty
        }
        titleErrorLabel.isHidden = isTitleRight
    }
    private func checkBodyForError() {
        if let body = postBodyTextView.text {
            isBodyRight = !body.isEmpty && body.count >= 10
        }
        bodyErrorLabel.isHidden = isBodyRight
    }
}
    // MARK: - Extensions
extension NewPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkBodyForError()
    }
}
