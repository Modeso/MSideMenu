//
//  SideMenuNavigationController.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import UIKit

/**
    SideMenuNavigationController:
        - The Navigation Controller of the Side Menu.
    How to use:
        - Just use this navigation controller as entery point and it should has a root view controller.
 */
open class SideMenuNavigationController: UINavigationController {

    /// transitionDelegate: Custom transition manager to mange the custom Modal transition for the side menu.
    fileprivate let transitionDelegate: SideMenuTransitionsManager = SideMenuTransitionsManager()
    
    /// tapGesture: gesture recognizer to handle dismissing the menu on Clicking on the content view controller.
    fileprivate var tapGesture: UITapGestureRecognizer?

    @IBInspectable open var sideMenuImage: UIImage?
    
    // MARK: - Init

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setupGestureRecognizer()
    }
    

    // MARK: - Private Helper functions

    /**
        This method is used to setup the gesture recognizer that will be used to dismiss the menu on tapping on the content view controller.
     */
    fileprivate func setupGestureRecognizer() {
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSideMenu))
        self.tapGesture?.numberOfTapsRequired = 1
        guard let tapGesture = self.tapGesture else {
            return
        }
        self.view.addGestureRecognizer(tapGesture)
    }
    
    /**
        This method is used to setup left bar button to be used as side menu button, if no image provided, Menu title will be used
        - Parameter viewController:  The view controller that will have the side menu button
     */

    fileprivate func setupSideMenuBarButton(_ viewController: UIViewController) {

        guard let image = self.sideMenuImage else {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(didTapSideMenu))
            return
        }

        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapSideMenu))
    }

}

// MARK: - UINavigationControllerDelegate

extension SideMenuNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        /// set the menu as left bar button
        self.setupSideMenuBarButton(viewController)
    }
}

// MARK: - Actions

extension SideMenuNavigationController {
    
    /**
        This method is used to handle clicking on the menu button in the navigation controller.
        It checks if the side menu is presented, then close the side menu, and if it's not presented, persent the side menu with the custom transition
    */
    func didTapSideMenu() {
    
        guard let _  = self.presentedViewController else {
            
            // present the left side menu...
            self.tapGesture?.isEnabled = SideMenuManager.shouldDismissOnTappingContentVC
            SideMenuManager.sideMenuViewController?.transitioningDelegate = transitionDelegate
            // add gesture for the visible view controller
            guard let sideMenuVC = SideMenuManager.sideMenuViewController else {
                return
            }
            self.present(sideMenuVC, animated: true, completion: nil)

            
            return
        }
        self.closeSideMenu()
    }
    
    /**
        This method is used to close the side menu.
     */
    open func closeSideMenu() {
        
        guard let presented = self.presentedViewController else {
            return
        }
        self.tapGesture?.isEnabled = false
        presented.dismiss(animated: true, completion: nil)
    }
 
}
