//
//  Book.swift
//  FavoriteBooks
//
//  Created by Berlin Thomas on 2024-03-19.
//

import Foundation

struct Book: CustomStringConvertible {
    
    let title: String
    let author: String
    let genre: String
    let length: String
    
    var description: String {
        return "\(title) is written by \(author) in the \(genre) genre and is \(length) pages long"
    }
}
