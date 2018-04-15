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

class RxIndexViewModel: IndexViewModel {
    //Helpers
    private var fetcher: StoryFetching
    var disposeBag: DisposeBag = DisposeBag()

    //State
    private var stories: [VanillaStory] = [VanillaStory]()
    var shownStories: Variable<[VanillaStory]> = Variable<[VanillaStory]>([])
    var error: Variable<Error?> = Variable<Error?>(nil)

    init(input: Observable<String>, fetcher: StoryFetching) {
        self.fetcher = fetcher
        input   .debounce(0.5, scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .subscribe { text in
                    if text.element?.isEmpty ?? true {
                        self.shownStories.value = self.stories
                        return
                    }
                    let shownStories = self.stories.filter { $0.headline.lowercased().contains(text.element ?? "") }
                    self.shownStories.value = shownStories
                }.disposed(by: self.disposeBag)
    }

    func fetchStories(forceError: Bool) {
        let index: Index = forceError ? .error : .frontPage
        self.fetcher.fetchStories(for: index) { (result) in
            switch result {
            case .success(result: let stories):
                self.handleSuccess(stories: stories)
                break
            case .failure(error: let error):
                self.handleFailure(error: error)
                break
            }
        }
    }

    private func handleSuccess(stories: [StoryProtocol]) {
        guard let stories = stories as? [VanillaStory] else {
            return
        }

        self.stories            = stories
        self.shownStories.value = stories
    }

    private func handleFailure(error: Error) {
        self.error.value = error
    }
}

