//
//  Story.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

class KVOStory : NSObject, StoryProtocol {
    var headline: String
    var summary: String

    required init(headline: String, summary: String) {
        self.headline = headline
        self.summary = summary
    }
}
