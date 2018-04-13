//
//  DefaultIndexViewModel2.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

@objc class DefaultIndexViewModel2 : NSObject, IndexViewModel {
    @objc dynamic var stories: [Story] = [Story]()

    func fetchStories() {
        let story1 = Story(headline: "Test 1", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story1)

        let story2 = Story(headline: "Test 2", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story2)

        let story3 = Story(headline: "Test 3", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story3)

        let story4 = Story(headline: "Test 4", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story4)


        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let story5 = Story(headline: "Test 5", summary: "Test 1", imageLink: "test 1")
            self.stories.append(story5)
        }
    }
}
