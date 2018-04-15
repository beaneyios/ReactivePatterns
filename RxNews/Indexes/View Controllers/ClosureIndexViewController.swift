//
//  IndexViewController.swift
//  RxNews
//
//  Created by Matthew Beaney on 13/04/2018.
//  Copyright © 2018 Matthew Beaney. All rights reserved.
//

import Foundation
import UIKit

class ClosureIndexViewController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!

    var vm: ClosureIndexViewModel?
    var dependencyManager: IndexDependencyCreating = ClosureIndexDependencyFactory()

    //MARK: SETUP.
    override func viewDidLoad() {
        self.configureVM()
        self.configureCollectionView()
        self.vm?.fetchStories(forceError: false)
    }

    func configureVM() {
        let fetcher = self.dependencyManager.fetchStoryFetching()
        let searcher = self.dependencyManager.fetchSearcher() ?? LocalStorySearcher()
        self.vm = ClosureIndexViewModel(fetcher: fetcher, searcher: searcher)

        self.vm?.shownStories.bind(withListener: { _ in
            self.presentStoriesUpdated()
        })

        self.vm?.error.bind(withListener: {
            self.presentAlertError(error: $0)
        })
    }

    func configureCollectionView() {
        let nib = UINib(nibName: PromoCollectionViewCell.Identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: PromoCollectionViewCell.Identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    //MARK: UI FEEDBACK.
    func presentStoriesUpdated() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func presentAlertError(error: Error) {
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

    @IBAction func textChanged(_ sender: Any) {
        guard let searchText = self.searchField.text else { return }
        self.vm?.filterStories(input: searchText)
    }
}

extension ClosureIndexViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.Identifier, for: indexPath) as? PromoCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard
            let stories: [VanillaStory] = self.vm?.shownStories.value
        else
        {
            return cell
        }

        let story = stories[indexPath.row]
        cell.configure(story: story)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm?.shownStories.value?.count ?? 0
    }
}

extension ClosureIndexViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}


