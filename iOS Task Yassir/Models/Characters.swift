//
//  User.swift
//  QosoorApp
//
//  Created by Ammar AlTahhan on 16/07/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation

class Characters: Codable {
    var info: Info?
     var results: [Result]?
}

// MARK: - Info
struct Info: Codable {
    var count, pages: Int?
    var next: String?
    var prev: String?
}

// MARK: - Result
struct Result: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin, location: Location?
    var image: String? // Assuming this is just the filename or path, not a full URL
    var episode: [String]?
    var url: String?
    var created: String?
    
    // Computed property to convert image to URL
    var imageURL: URL? {
        guard let image = image else { return nil }
        return URL(string:image)
    }
}
