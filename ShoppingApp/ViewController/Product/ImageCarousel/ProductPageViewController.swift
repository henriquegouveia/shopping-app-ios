//
//  ProductPageViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 02/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit

class ProductPageViewController: UIPageViewController, ProductPageProtocol {
    private var _pages: [UIViewController] = []
    
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
        let viewControllers = self.productImages.map{ instantiateImageViewController(productImage: $0)! }
        self._pages = viewControllers
        
        guard let firstPage = self._pages.first else { return }
        setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
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
        guard self._pages.count > previousIndex else { return nil        }
        
        return self._pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = self._pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < self._pages.count else { return self._pages.first }
        guard self._pages.count > nextIndex else { return nil         }
        
        return self._pages[nextIndex]
    }
}
