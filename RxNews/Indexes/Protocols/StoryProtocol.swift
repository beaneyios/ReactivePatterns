//
//  ArticleProtocol.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

protocol StoryProtocol {
    init(headline: String, summary: String)
    var headline: String { get set }
    var summary: String { get set }
}
