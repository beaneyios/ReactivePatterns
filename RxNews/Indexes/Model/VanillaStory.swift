//
//  VanillaStory.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

class VanillaStory : StoryProtocol {
    var headline    : String
    var summary     : String

    required init(headline: String, summary: String) {
        self.headline = headline
        self.summary = summary
    }
}
