//
//  SideMenuManager.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import Foundation

/*  SideMenuManager: Manager class to handle configuration for the side menu
 
 */
open class SideMenuManager {

    /// Duration of the animation that the menu needs to be presented. Default is 0.35 seconds.
    open static var presentationDuration: Double = 0.35
    
    /// Duration of the animation that the menu needs to be dismissed. Default is 0.35 seconds.
    open static var dismissDuration: Double = 0.35

    /// The scale of the content view controller
    open static var contentViewControllerScale: CGFloat = 0.5

    /// The amount of translation in X direction.
    open static var xTranslation: CGFloat = 0.75
    
    /// The amount of translation in Y direction.
    open static var yTranslation: CGFloat = 0.3

    /// The amount of opacity of the content view controller.
    open static var contentViewControllerOpacity: CGFloat = 0.8
    
    /// Side menu view controller 
    open static var sideMenuViewController: UIViewController?

}
