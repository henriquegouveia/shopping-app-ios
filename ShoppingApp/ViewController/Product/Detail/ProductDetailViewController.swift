//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController {

    private let _viewModel = ProductViewModel()
    private let _mediator = ProductMediator()
    private let _disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindFields()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productImagesProtocol = String(describing: ProductPageProtocol.self)
        let recommendationsProtocol = String(describing: RecommendationsProtocol.self)
        let values: [String : Any] = [productImagesProtocol: self._viewModel.productImages,
                      recommendationsProtocol: self._viewModel.recommendations]
        self._mediator.prepare(for: segue, sender: values)
    }
    
    // MARK: - Private Functions
    
    private var customView: ProductDetailView {
        return self.view as! ProductDetailView
    }
    
    private func bindFields() {
        self._viewModel.productName.bind(to: self.customView.productNameLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.productText.bind(to: self.customView.productTextLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.price.bind(to: self.customView.priceLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.deliveredWith.bind(to: self.customView.deliveredWithLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.hideNextDayDelivery.bind(to: self.customView.nextDayDeliveryImageView.rx.isHidden).disposed(by: self._disposeBag)
        self._viewModel.isLoading.subscribe(onNext: { [weak self] (isLoading) in
            guard let weakSelf = self else { return }
            isLoading ? weakSelf.customView.activityIndicator.startAnimating() : weakSelf.customView.activityIndicator.stopAnimating()
            weakSelf.customView.loadingView.isHidden = !isLoading
        }).disposed(by: self._disposeBag)
        self._viewModel.isLoading.bind(to: self.customView.deliveredByLabel.rx.isHidden).disposed(by: self._disposeBag)
        
    }

}

extension ProductDetailViewController: ProductDetailProtocol {
    var product: ProductDetail? {
        return self._viewModel.productDetail
    }
    
    func showProductDetails(product: Product) {
        self._viewModel.updateProduct(product: product)
    }
}
