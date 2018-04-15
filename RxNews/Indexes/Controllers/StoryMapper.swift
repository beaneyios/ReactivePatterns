//
//  ArticleMapper.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

struct StoryMapper<T: StoryProtocol> : StoryMapping {
    private var indexParser: IndexParsing

    init(indexParser: IndexParsing) {
        self.indexParser = indexParser
    }

    func mapArticles(fromData data: Data) -> Result<[StoryProtocol]> {
        let articlesArrayResult = self.indexParser.fetchArticlesArray(from: data)

        switch articlesArrayResult {
        case .failure(error: let error):
            return Result.failure(error: error)
        case .success(result: let articlesArray):
            return self.parseArticlesArray(articlesArray: articlesArray)
        }
    }

    private func parseArticlesArray(articlesArray: [[AnyHashable : Any]]) -> Result<[StoryProtocol]> {

        var articles = [T]()

        for article in articlesArray {
            guard
                let storyDict       = article["content"] as? [AnyHashable : Any],
                let storyHeadline   = storyDict["name"] as? String,
                let storySummary    = storyDict["summary"] as? String
                else
            {
                continue
            }

            let story = T(headline: storyHeadline, summary: storySummary)
            articles.append(story)
        }

        return Result.success(result: articles)
    }
}
