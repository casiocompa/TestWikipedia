//
//  CustomNavigationController.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 30.10.2023.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
}

extension CustomNavigationController {
    
    func configure(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = .none
        appearance.shadowImage = UIImage()
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        
        self.navigationBar.frame.size = self.navigationBar.sizeThatFits(
            CGSize(
                width: self.navigationBar.frame.size.width,
                height: 55
            )
        )
        
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
}
