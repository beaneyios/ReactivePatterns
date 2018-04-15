//
//  ClosureIndexViewModel.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

class ClosureIndexViewModel : IndexViewModel {
    //Helpers
    private var fetcher: StoryFetching
    private var searcher: StorySearching

    //State
    private var stories = [VanillaStory]()
    var shownStories = CustomObservable<[VanillaStory]>()
    var error: CustomObservable<Error> = CustomObservable<Error>()

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
                self.error.value = error
                break
            }
        }
    }

    private func handleSuccess(stories: [StoryProtocol]) {
        guard let stories = stories as? [VanillaStory] else { return }

        self.stories = stories
        self.shownStories.value = stories
    }

    func filterStories(input: String) {
        self.searcher.search(searchText: input, stories: self.stories) { (stories) in
            self.shownStories.value = stories as? [VanillaStory]
        }
    }
}
