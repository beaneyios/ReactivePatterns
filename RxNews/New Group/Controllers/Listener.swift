//
//  Listener.swift
//  RxNews
//
//  Created by Matthew Beaney on 15/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation

struct CustomObservable<T> {
    var value: T? {
        didSet {
            self.updateListeners(value: self.value)
        }
    }

    typealias Listener = (T) -> ()
    var listeners: [Listener] = [Listener]()

    mutating func bind(withListener listener: @escaping Listener) {
        self.listeners.append(listener)
    }

    func updateListeners(value: T?) {
        guard let value = value else { return }
        for listener in listeners {
            listener(value)
        }
    }
}
