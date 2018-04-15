//
//  DefaultIndexViewModel2.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

@objc class KVOIndexViewModel : NSObject, IndexViewModel {
    //Helpers
    private var fetcher: StoryFetching
    private var searcher: StorySearching

    //State
    @objc dynamic var shownStories: [KVOStory] = [KVOStory]()
    @objc dynamic var downloadError: Error?
    private var stories: [KVOStory] = [KVOStory]()

    init(fetcher: StoryFetching, searcher: StorySearching) {
        self.fetcher = fetcher
        self.searcher = searcher
    }

    func fetchStories(forceError: Bool) {
        let index: Index = forceError ? .error : .frontPage
        self.fetcher.fetchStories(for: index) { (result) in
            switch result {
            case .success(result: let stories):
                self.handleSuccess(stories: stories)
                break
            case .failure(error: let error):
                self.handleFailure(error: error)
                break
            }
        }
    }

    func filterStories(input: String) {
        self.searcher.search(searchText: input, stories: self.stories) { (stories) in
            self.shownStories = stories as? [KVOStory] ?? self.stories
        }
    }

    private func handleSuccess(stories: [StoryProtocol]) {
        guard let stories = stories as? [KVOStory] else { return }
        self.stories = stories
        self.shownStories = stories
    }

    private func handleFailure(error: Error) {
        self.downloadError = error
    }
}
