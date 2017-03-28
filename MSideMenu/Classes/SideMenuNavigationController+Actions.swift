//
//  SideMenuNavigationController+Actions.swift
//  Pods
//
//  Created by Esraa on 3/28/17.
//
//

import Foundation


// MARK: - Actions

extension SideMenuNavigationController {
    
    /**
     This method is used to handle clicking on the menu button in the navigation controller.
     It checks if the side menu is presented, then close the side menu, and if it's not presented, persent the side menu with the custom transition
     */
    func didTapSideMenu() {
        
        guard let _  = self.presentedViewController else {
            
            // present the left side menu...
            self.tapGesture?.isEnabled = self.shouldDismissOnTappingContentVC
            self.sideMenuViewController?.transitioningDelegate = transitionDelegate
            // add gesture for the visible view controller
            guard let sideMenuVC = self.sideMenuViewController else {
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
