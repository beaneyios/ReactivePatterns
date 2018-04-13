//
//  IndexViewController.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation
import UIKit

class IndexViewController2 : UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var vm: DefaultIndexViewModel2?
    var observer: NSKeyValueObservation?

    override func viewDidLoad() {
        self.configureCollectionView()
        self.vm = DefaultIndexViewModel2()
        self.observer = self.vm?.observe(\.stories, changeHandler: { (vm, stories) in
            self.collectionView.reloadData()
        })

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.vm?.fetchStories()
    }

    func configureCollectionView() {
        let nib = UINib(nibName: PromoCollectionViewCell.Identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: PromoCollectionViewCell.Identifier)
    }
}

extension IndexViewController2 : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.Identifier, for: indexPath) as? PromoCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard let story = self.vm?.stories[indexPath.row] else { return cell }

        cell.configure(story: story)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm?.stories.count ?? 0
    }
}

extension IndexViewController2 : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}

