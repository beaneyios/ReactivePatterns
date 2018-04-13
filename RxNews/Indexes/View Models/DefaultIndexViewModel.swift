//
//  IndexViewModel.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DefaultIndexViewModel: IndexViewModel {
    var stories: [Story] = [Story]()
    var shownStories: Variable<[Story]> = Variable<[Story]>([])
    var disposeBag: DisposeBag = DisposeBag()

    convenience init(input: UITextField) {
        self.init()
        input   .rx
                .text
                .orEmpty
                .debounce(0.5, scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .subscribe { text in
                    if text.element?.isEmpty ?? true {
                        self.shownStories.value = self.stories
                        return
                    }
                    let shownStories = self.stories.filter { $0.headline.contains(text.element ?? "") }
                    self.shownStories.value = shownStories
                }.disposed(by: self.disposeBag)
    }

    func fetchStories() {
        let story1 = Story(headline: "Test 1", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story1)

        let story2 = Story(headline: "Test 2", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story2)

        let story3 = Story(headline: "Test 3", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story3)

        let story4 = Story(headline: "Test 4", summary: "Test 1", imageLink: "test 1")
        self.stories.append(story4)

        self.shownStories.value = self.stories


        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let story5 = Story(headline: "Test 5", summary: "Test 1", imageLink: "test 1")
            self.stories.append(story5)
            self.shownStories.value = self.stories
        }
    }
}

