//
//  RecommendationCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 04/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit
import RxSwift
import Nuke

protocol RecommendationCellProtocol: class {
    func loadData(item: Int)
}

class RecommendationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var _disposeBag = DisposeBag()
    private var _viewModel: RecommendationCellViewModel! {
        didSet {
            self.bind()
            self._viewModel.fetchProductDetails()
        }
    }
    
    private func bind() {
        self._viewModel
            .price
            .bind(to: self.priceLabel.rx.text)
            .disposed(by: self._disposeBag)
        
        self._viewModel
            .productImage
            .subscribe(onNext: { [weak self] (imageURL) in
                guard let weakSelf = self else { return }
                weakSelf.downloadImage(imageURL: imageURL)
            }).disposed(by: self._disposeBag)
    }
    
    private func downloadImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        Nuke.loadImage(with: url, into: self.productImageView)
    }
}

// MARK: - RecommendationCellProtocol Impl

extension RecommendationCollectionViewCell: RecommendationCellProtocol {
    func loadData(item: Int) {
        self.productImageView.image = nil
        self.priceLabel.text = nil
        self._viewModel = RecommendationCellViewModel(productId: item)
    }
}


