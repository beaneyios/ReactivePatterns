//
//  StorySearching.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

protocol StorySearching {
    func search(searchText: String, stories: [StoryProtocol], completion: @escaping (_ results: [StoryProtocol]) -> Void)
}
