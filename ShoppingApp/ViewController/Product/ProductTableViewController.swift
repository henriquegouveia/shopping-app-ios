//
//  ProductTableViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: - Cell Protocol

protocol ProductCellProtocol {
    func loadData(product: ProductList.Product)
}

// MARK: Class

class ProductTableViewController: UITableViewController {
    
    // MARK: - Constant Properties
    
    internal let searchController = UISearchController(searchResultsController: nil)
    internal let searchClient = SearchClient()
    internal let disposableBag = DisposeBag()
    
    // MARK: - Properties
    
    internal let viewModel = ProductListViewModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBar()
        
        self.bindProducts(with: self.viewModel)
        
        //register it on view
        self.tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    // MARK: - Datasource Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Private Methods
    
    private func bindProducts(with viewModel: ProductListViewModel) {
        viewModel.products
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: ProductTableViewCell.self),
                                         cellType: ProductTableViewCell.self)) {index, product, cell in
                cell.loadData(product: product)
            }
            .disposed(by: self.disposableBag)
    }
    
    private func configureTable() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
    }
    
    private func configureSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.placeholder = "Search Products"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        
        self.searchController.searchBar.rx.text.orEmpty.subscribe(onNext: {[weak self] query in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.getProducts(query: query)
        }).disposed(by: disposableBag)
        
    }
    
}

// MARK: - UISearchController implementation

extension ProductTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
}
