//
//  ProductTableViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Cell Protocol

protocol ProductCellProtocol {
    func loadData(product: ProductViewModel)
}

// MARK: Class

class ProductTableViewController: UITableViewController {
    
    // MARK: - Constant Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    internal let productClient = ProductClient()
    
    // MARK: - Properties
    
    internal let viewModel = ProductListViewModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBar()
        
        self.tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    // MARK: - Datasource Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell")
        if let cell = cell as? ProductCellProtocol {
            cell.loadData(product: self.viewModel.products[indexPath.item])
        }
        
        return cell!
    }
    
    // MARK: - Private Methods
    
    private func configureSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.placeholder = "Search Candies"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
}

// MARK: - UISearchController implementation

extension ProductTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
}
