//
//  SideMenuNavigationController.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import UIKit

open class SideMenuNavigationController: UINavigationController {

    fileprivate let transitionDelegate: SideMenuTransitionsManager = SideMenuTransitionsManager()
    fileprivate var tapGesture: UITapGestureRecognizer?

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSideMenu))
        self.tapGesture?.numberOfTapsRequired = 1
        guard let tapGesture = self.tapGesture else {
            return
        }
        self.view.addGestureRecognizer(tapGesture)
    }
    open func closeSideMenu() {
        if let presented = self.presentedViewController {
            self.tapGesture?.isEnabled = false
            presented.dismiss(animated: true, completion: nil)
            
        }
    }
}

/// Delegate
extension SideMenuNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        /// 
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(didTapSideMenu))
    }
}
/// action
extension SideMenuNavigationController {
    
    func didTapSideMenu() {
        // present the left side menu...
        if let presented = self.presentedViewController {
            self.tapGesture?.isEnabled = false
            presented.dismiss(animated: true, completion: nil)

        }else {
            self.tapGesture?.isEnabled = true
            SideMenuManager.sideMenuViewController?.transitioningDelegate = transitionDelegate
            // add gesture for the visible view controller
            guard let sideMenuVC = SideMenuManager.sideMenuViewController else {
                return
            }
            self.present(sideMenuVC, animated: true, completion: nil)
        }
    }
 
}
