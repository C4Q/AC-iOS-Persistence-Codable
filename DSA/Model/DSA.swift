//
//  DSA.swift
//  DSA
//
//  Created by Alex Paul on 12/8/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import Foundation

class DSA: Codable {
    var title: String
    var dsaDescription: String

    init(title: String, description: String) {
        self.title = title
        self.dsaDescription = description
    }
}
