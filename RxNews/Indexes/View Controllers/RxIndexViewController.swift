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

class RxIndexViewController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!

    var vm: RxIndexViewModel?
    var disposeBag: DisposeBag = DisposeBag()
    var depencencyManager: IndexDependencyCreating = VanillaIndexDependencyFactory()

    //MARK: SETUP.
    override func viewDidLoad() {
        self.configureCollectionView()
        self.configureVM()
        self.vm?.fetchStories(forceError: false)
    }

    func configureVM() {
        let fetcher = depencencyManager.fetchStoryFetching()
        self.vm = RxIndexViewModel(input: self.searchTextField.rx.text.orEmpty.asObservable(), fetcher: fetcher)

        self.vm?    .shownStories
            .asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: PromoCollectionViewCell.Identifier, cellType: PromoCollectionViewCell.self)) { row, story, cell in
                cell.configure(story: story)
            }
            .disposed(by: disposeBag)

        self.vm?    .error
                    .asObservable()
                    .bind(onNext: { (error) in
                        self.presentAlertError(error: error)
                    }).disposed(by: disposeBag)
    }

    func configureCollectionView() {
        let nib = UINib(nibName: PromoCollectionViewCell.Identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: PromoCollectionViewCell.Identifier)
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }

    //MARK: UI FEEDBACK.
    func presentAlertError(error: Error?) {
        guard let error = error else { return }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "There was an error", message: "Error code \((error as NSError).code)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }

    //MARK: ACTIONS.
    @IBAction func forceError(_ sender: Any) {
        self.vm?.fetchStories(forceError: true)
    }
}

extension RxIndexViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}
