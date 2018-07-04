//
//  RecommendedCollectionViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 03/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = String(describing: RecommendationCollectionViewCell.self)

class RecommendedCollectionViewController: UICollectionViewController {

    private var _disposeBag = DisposeBag()
    var viewModel: RecommendationListViewModel! {
        didSet {
            bindCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindCollectionView() {
        guard let viewModel = self.viewModel, let collectionView = self.collectionView else { return }
        viewModel.dataSource.bind(to: collectionView.rx.items(cellIdentifier: reuseIdentifier, cellType: RecommendationCollectionViewCell.self)) { index, product, cell in
            cell.loadData(item: product)
        }.disposed(by: self._disposeBag)
        
    }

}

extension RecommendedCollectionViewController: RecommendationsProtocol {
    func observableDatasouce<T>(_ observable: Observable<[T]>) {
        guard let observable = observable as? Observable<[Int]> else { return }
        observable.subscribe(onNext: { [weak self] (recommendations) in
            guard let weakSelf = self else { return }
            weakSelf.viewModel = RecommendationListViewModel(recommendations: recommendations)
        }).disposed(by: self._disposeBag)

    }
}
