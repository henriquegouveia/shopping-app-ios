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
    func loadData(product: Product)
}

// MARK: Class

class ProductTableViewController: UITableViewController, BaseViewControllerProtocol {
    
    weak var delegate: ProductDetailProtocol?
    
    // MARK: - Constant Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let disposableBag = DisposeBag()
    
    // MARK: - Properties
    
    private let viewModel = ProductListViewModel() 
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureSearchBar()
        self.configureTable()
        self.configureTableViewDelegate()
        self.configureView()
        
        self.bindProducts(with: self.viewModel)
        self.bindLoading(with: self.viewModel)
        self.bindError(with: self.viewModel)
    }
    
    // MARK: - Datasource Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Private Methods
    
    private func bindLoading(with viewModel: ProductListViewModel) {
        viewModel.isLoading
            .bind(to: self.rx_loading)
            .disposed(by: self.disposableBag)
    }
    
    private func bindError(with viewModel: ProductListViewModel) {
        viewModel.error
        .bind(to: self.rx_error)
        .disposed(by: self.disposableBag)
    }
    
    private func bindProducts(with viewModel: ProductListViewModel) {
        viewModel.products.bind(to: tableView.rx.items(cellIdentifier: String(describing: ProductTableViewCell.self),
                                         cellType: ProductTableViewCell.self)) { index, product, cell in
                                            cell.loadData(product: product)
            }
            .disposed(by: self.disposableBag)
    }
    
    private func selectFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
    }
    
    private func configureTableViewDelegate() {
        self.tableView.rx.modelSelected(Product.self).subscribe(onNext: { [weak self] (product) in
            guard let weakSelf = self else { return }
            weakSelf.showDetailsWhenIsCollapsed()
            weakSelf.delegate?.showProductDetails(product: product)
        }).disposed(by: self.disposableBag)
        
        self.tableView.rx.willDisplayCell.subscribe(onNext:  { [weak self] (cellInfo)  in
            guard let weakSelf = self else { return }
            if (cellInfo.indexPath.item == weakSelf.viewModel.endIndex) {
                weakSelf.viewModel.getProducts()
            }
        }).disposed(by: self.disposableBag)
    }
    
    private func configureTable() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        let cellIdentifier = String(describing: ProductTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func configureView() {
        self.navigationItem.title = self.viewModel.title
    }
    
    private func configureSearchBar() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = NSLocalizedString("Search Products", comment: "")
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        
        self.searchController.searchBar
            .rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] query in
                guard let weakSelf = self else { return }
                weakSelf.viewModel.filterProducts(query: query)
        }).disposed(by: disposableBag)
        
        self.searchController.searchBar.rx.cancelButtonClicked.subscribe(onNext: { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.didEndSearching()
        }).disposed(by: disposableBag)
    }
    
    private func showDetailsWhenIsCollapsed() {
        if self.splitViewController!.isCollapsed {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ProductDetailViewController.self))
            guard let detailController = viewController as? ProductDetailProtocol else { return }
            self.delegate = detailController
            self.splitViewController?.showDetailViewController(viewController, sender: self)
        }
    }
}
