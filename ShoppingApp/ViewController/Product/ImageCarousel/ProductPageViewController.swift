//
//  ProductPageViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 02/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ProductPageViewController: UIPageViewController {
    private var _pages: [UIViewController] = []
    private let _disposeBag = DisposeBag()
    
    var productImages: [String] = [] {
        didSet {
            self.setupViewControllers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
    }
    
    // MARK: - Private Functions
    
    private func setupViewControllers() {
        let viewControllers = self.productImages.map{ self.instantiateImageViewController(productImage: $0)! }
        self._pages.append(contentsOf: viewControllers)
        
        self.setViewControllers([viewControllers.first!], direction: .forward, animated: true, completion: nil)
    }
    
    private func instantiateImageViewController(productImage: String?) -> UIViewController? {
        guard let productImage = productImage else { return  nil}
        let viewControllerIdentifier = String(describing: ProductImageViewController.self)
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewControllerIdentifier) as? ProductImageProtocol else { return nil }
        viewController.productImage = productImage
        
        return viewController as? UIViewController
    }
    
}

// MARK: - Page Controller Datasource

extension ProductPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self._pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return self._pages.last }
        guard self._pages.count > previousIndex else { return nil }
        
        return self._pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self._pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < self._pages.count else { return self._pages.first }
        guard self._pages.count > nextIndex else { return nil }
        
        return self._pages[nextIndex]
    }
}

// MARK: - Page Protocol Impl

extension ProductPageViewController: ProductPageProtocol {
    func observableDatasouce(_ observable: Observable<[String]>) {
        observable.subscribe(onNext: { (images) in
            if images.count > 0 {
                self.productImages = images
            }
        }).disposed(by: self._disposeBag)
    }
}
