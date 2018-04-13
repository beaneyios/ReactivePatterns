//
//  IndexViewController.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class IndexViewController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!

    var vm: DefaultIndexViewModel?
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        self.configureCollectionView()
        self.vm = DefaultIndexViewModel(input: self.searchTextField)

        self.vm?    .shownStories
                    .asObservable()
                    .bind(to: collectionView.rx.items(cellIdentifier: PromoCollectionViewCell.Identifier, cellType: PromoCollectionViewCell.self)) { row, story, cell in
                        cell.configure(story: story)
                    }
                    .disposed(by: disposeBag)

        self.vm?.fetchStories()
    }

    func configureCollectionView() {
        let nib = UINib(nibName: PromoCollectionViewCell.Identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PromoCollectionViewCell.Identifier)
        collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
}

extension IndexViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}
