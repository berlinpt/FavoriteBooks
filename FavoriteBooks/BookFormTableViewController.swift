//
//  BookFormTableViewController.swift
//  FavoriteBooks
//
//  Created by Berlin Thomas on 2024-03-19.
//

import UIKit

class BookFormTableViewController: UITableViewController {
    
    var book: Book?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var lengthTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    init?(coder: NSCoder, book: Book?) {
        self.book = book
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            titleTextField.text = book.title
            authorTextField.text = book.author
            genreTextField.text = book.genre
            lengthTextField.text = book.length
            title = "Edit Book"
        }
        else {
            title = "Add Book"
        }
        
        updateSaveButtonState()
    }
    
    @IBAction func textEditingChanged(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let titleText = titleTextField.text ?? ""
        let authorText = authorTextField.text ?? ""
        let genreText = genreTextField.text ?? ""
        let lengthText = lengthTextField.text ?? ""
        
        saveButton.isEnabled = !titleText.isEmpty && !authorText.isEmpty && !genreText.isEmpty && !lengthText.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        let title = titleTextField.text!
        let author = authorTextField.text ?? ""
        let genre = genreTextField.text ?? ""
        let length = lengthTextField.text ?? ""
        book = Book(title: title, author: author, genre: genre, length: length)
    }
    
}
