//
//  StoryFetching.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

protocol StoryFetching {
    func fetchStories(for index: Index, completion: @escaping (_ result: Result<[StoryProtocol]>) -> Void)
}
