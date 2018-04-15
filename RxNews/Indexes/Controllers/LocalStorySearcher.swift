//
//  LocalStorySearcher.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

struct LocalStorySearcher : StorySearching {
    private var debouncer: Debouncer = Debouncer(interval: 0.5)
    
    func search(searchText: String, stories: [StoryProtocol], completion: @escaping ([StoryProtocol]) -> Void) {
        self.debouncer.callback = {
            if searchText.isEmpty {
                completion(stories)
                return
            }

            let filteredStories = stories.filter { $0.headline.lowercased().contains(searchText) }
            completion(filteredStories)
        }

        self.debouncer.call()
    }
}
