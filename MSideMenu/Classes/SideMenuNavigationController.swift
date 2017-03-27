//
//  SideMenuNavigationController.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import UIKit

class SideMenuNavigationController: UINavigationController {

    fileprivate let transitionDelegate: SideMenuTransitionsManager = SideMenuTransitionsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}
/// Delegate
extension SideMenuNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        /// 
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(didTapSideMenu))
    }
}
/// action

extension SideMenuNavigationController {
    
    func didTapSideMenu() {
        // present the left side menu...
        if let presented = self.presentedViewController {
            presented.dismiss(animated: true, completion: nil)
        }else {
            SideMenuManager.sideMenuViewController?.transitioningDelegate = transitionDelegate
            self.present(SideMenuManager.sideMenuViewController!, animated: true, completion: nil)
        }
    }
}
