//
//  Coordinator.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 29.10.2023.
//

import UIKit
import TinyConstraints

protocol Coordinator {
    
    var navigationController: UINavigationController {
        get set
    }
    
    func openVC(
        type: (ControllerHasCoordinator & UIViewController).Type
    )
    
    func openVC(
        type: UIViewControllerCoordinatorAndParams.Type,
        with params: [String : Any]
    )
    
    func goBack()
}

final class AppCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func openVC(
        type: (UIViewController & ControllerHasCoordinator).Type
    ) {
        var vc = type.init()
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func openVC(
        type: UIViewControllerCoordinatorAndParams.Type,
        with params: [String : Any]
    ) {
        let vc = type.init()
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        vc.params = params
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UIViewController with coordinator
protocol ControllerHasCoordinator {
    var coordinator : AppCoordinator? {
        get set
    }
}

class UIViewControllerCoordinator : UIViewController, ControllerHasCoordinator {
    weak var coordinator : AppCoordinator?
}

//MARK: - UIViewController with coordinator and params
class UIViewControllerCoordinatorAndParams : UIViewControllerCoordinator, ControllerHasParams {
    var params: [String : Any]?
}

protocol ControllerHasParams {
    var params : [String:Any]? {
        get set
    }
}

//MARK: - UIViewControllerCoordinator
extension UIViewControllerCoordinator {
    
    @objc func goBack(){
        guard let coordinator = self.coordinator else {
            return
        }
        coordinator.goBack()
    }
    
    func setUpNavBarBackBtn(){
        
        let backItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: #selector(
                self.goBack
            )
        )
        self.navigationItem.backBarButtonItem = backItem
        
    }
    
    func setUpRightNavBarItem(menuBtn: UIButton, selector: Selector){
        
        menuBtn.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: 50,
            height: 50
        )
        menuBtn.addTarget(
            self,
            action: selector,
            for: .touchUpInside
        )
        
        let menuBarItem = UIBarButtonItem(
            customView: menuBtn
        )
        self.navigationItem.rightBarButtonItem = menuBarItem
        
    }
    
    func setUpNavigationTitle(text: String){
        
        let titleView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 25,
            weight: .medium
        )
        label.textColor = .black
        label.textAlignment = .center
        label.text = text
        self.navigationItem.title = text
        
        titleView.addSubview(
            label
        )
        
        label.centerXToSuperview()
        label.centerYToSuperview()
        
        self.navigationItem.titleView = titleView
        
    }
    
}
