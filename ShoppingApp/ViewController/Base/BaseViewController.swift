//
//  BaseViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 29/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol BaseViewControllerProtocol: class {
    var rx_loading: AnyObserver<Bool> { get }
    var rx_error: AnyObserver<Error> { get }
    
    func showMessageError(error: Error)
}

extension BaseViewControllerProtocol {
    public var rx_loading: AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch (event) {
            case .next(let value):
                guard let controller = self as? UIViewController else { return }
                controller.view.isUserInteractionEnabled = !value
                controller.view.backgroundColor = value ? UIColor.black : UIColor.clear
            case .error(let error):
                let error = "Binding error to UI: \(error)"
                print(error)
            case .completed:
                break
            }
        }
    }
    
    public var rx_error: AnyObserver<Error> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch (event) {
            case .next(let value):
                self.showMessageError(error: value)
                break
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
    }
    
    //MARK: Public Functions
    
    func showMessageError(error: Error) {
        guard let controller = self as? UIViewController else { return }
        guard let customError = error as? CustomErrorConvertible else { return }
        
        let alert = UIAlertController.init(title: "Ops!", message: customError.userLocalizedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
