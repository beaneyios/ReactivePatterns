//
//  StoryFetcher.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

struct StoryFetcher : StoryFetching {
    private var root: String = "http://trevor-producer-cdn.api.bbci.co.uk/content/cps"
    private var mapper: StoryMapping

    init(mapper: StoryMapping) {
        self.mapper = mapper
    }

    func fetchStories(for index: Index, completion: @escaping (_ result: Result<[StoryProtocol]>) -> Void) {
        guard let url = URL(string: root + index.rawValue) else {
            return
        }

        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(Result.failure(error: error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "com.bbc.download", code: 500, userInfo: nil)
                completion(Result.failure(error: error as Error))
                return
            }

            let result = self.mapper.mapArticles(fromData: data)
            completion(result)
        }

        dataTask.resume()
    }    
}
