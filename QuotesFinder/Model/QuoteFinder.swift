//
//  QuoteFinder.swift
//  QuotesFinder
//
//  Created by Winston Wang on 2022-02-23.
//

import Foundation
struct QuoteFinder: Decodable, Hashable{
    let quoteText: String
    let quoteAuthor: String
    let senderName: String
    let senderLink: String
    let quoteLink: String
}
