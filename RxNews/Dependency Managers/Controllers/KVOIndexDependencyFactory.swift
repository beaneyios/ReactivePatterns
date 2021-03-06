//
//  KVOIndexDependencyFactory.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

struct KVOIndexDependencyFactory : IndexDependencyCreating {
    func fetchArticleMapper() -> StoryMapping {
        return StoryMapper<KVOStory>(indexParser: self.fetchIndexParsing())
    }

    func fetchStoryFetching() -> StoryFetching {
        return StoryFetcher(mapper: self.fetchArticleMapper())
    }

    func fetchIndexParsing() -> IndexParsing {
        return IndexParser()
    }

    func fetchSearcher() -> StorySearching? {
        return LocalStorySearcher()
    }
}
