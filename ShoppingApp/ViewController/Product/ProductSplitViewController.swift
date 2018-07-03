//
//  ProductSplitViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 02/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit

class ProductSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    private let _mediator = ProductMediator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.setupDetailViewController()
    }
    
    private func assignDelegate(_ delegate: ProductDetailProtocol, for viewController: UIViewController) {
        guard let primaryNavigationViewController = viewController as? UINavigationController else { return }
        guard let masterViewController = primaryNavigationViewController.topViewController as? ProductTableViewController else { return }
        
        masterViewController.delegate = delegate
    }
    
    private func setupDetailViewController() {
        guard let masterController = self.viewControllers.first else { return }
        guard let detailController = self.viewControllers.last as? ProductDetailProtocol else { return }
        self.assignDelegate(detailController, for: masterController)
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let detailController = secondaryViewController as? ProductDetailProtocol else { return false }
        
        if detailController.product == nil {
            return true
        }
        
        return false
    }

}
