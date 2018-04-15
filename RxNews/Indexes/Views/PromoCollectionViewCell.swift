//
//  PromoCollectionViewCell.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    static var Identifier: String = "PromoCollectionViewCell"

    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    
    private var story: StoryProtocol?

    func configure(story: StoryProtocol) {
        self.lblHeadline.text = story.headline
        self.lblSummary.text = story.summary
    }
}
