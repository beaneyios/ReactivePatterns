//
//  Story.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

@objc class Story : NSObject {
    var headline: String
    var summary: String
    var imageLink: String

    init(headline: String, summary: String, imageLink: String) {
        self.headline = headline
        self.summary = summary
        self.imageLink = imageLink
    }
}
