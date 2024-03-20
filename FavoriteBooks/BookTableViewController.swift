//
//  BookTableViewController.swift
//  FavoriteBooks
//
//  Created by Berlin Thomas on 2024-03-19.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    /* var books: [Book] = [
        Book(title: "Ikigai", author: "Héctor García, Francesc Miralles", genre: "Self-Help", length: "208"),
        Book(title: "Secret", author: "Rhonda Byrne", genre: "Self-Help", length: "216")
    ]
     */
    
    var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell

        let book = books[indexPath.row]
        cell.update(with: book)
        cell.showsReorderControl = true

        return cell
    }
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedBook = books.remove(at: fromIndexPath.row)
        books.insert(movedBook, at: to.row)
    }
    
    @IBSegueAction func editBook(_ coder: NSCoder, sender: Any?) -> BookFormTableViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return  nil }
        // Edit Book
        let bookToEdit = books[indexPath.row]
        return BookFormTableViewController(coder: coder, book: bookToEdit)
    }
    
    
    @IBSegueAction func addBook(_ coder: NSCoder, sender: Any?) -> BookFormTableViewController? {
        return BookFormTableViewController(coder: coder, book: nil)
    }
    
    @IBAction func unwindToBookTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? BookFormTableViewController,
              let book = sourceViewController.book else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            books[selectedIndexPath.row] = book
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        else {
            let newIndexPath = IndexPath(row: books.count, section: 0)
            books.append(book)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

}
