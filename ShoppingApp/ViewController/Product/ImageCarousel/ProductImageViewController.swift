//
//  ProductImageViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 02/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit
import RxNuke
import RxSwift
import Nuke

class ProductImageViewController: UIViewController, ProductImageProtocol {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    private let _disposeBag = DisposeBag()
    var productImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImage()
    }
    
    // MARK: - Private Functions
    
    private func loadImage() {
        guard let url = URL(string: productImage) else { return }
        ImagePipeline.shared.rx.loadImage(with: url)
            .subscribe(onSuccess: { self.productImageView.image = $0.image })
            .disposed(by: _disposeBag)
    }
    
}
