//
//  Result.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(result: T)
    case failure(error: Error)
}
