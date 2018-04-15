//
//  IndexParser.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

class IndexParser : IndexParsing {
    func fetchArticlesArray(from data: Data) -> Result<[[AnyHashable : Any]]> {
        let parsingErrorResult: () -> Result<[[AnyHashable : Any]]> = {
            let error = NSError(domain: "com.bbc.mapping", code: 500, userInfo: nil)
            return Result.failure(error: error)
        }

        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let dict = json as? [AnyHashable : Any]
            else
        {
            return parsingErrorResult()
        }

        guard let articlesArray = dict["relations"] as? [[AnyHashable : Any]] else {
            return parsingErrorResult()
        }

        return Result.success(result: articlesArray)
    }
}
