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
    open static var contentViewControllerScale: CGFloat = 0.7

    /// The amount of translation in X direction, Default is 0.0 and it will stay in the middle width of the screen
    open static var xTranslation: CGFloat = 0.5
    
    /// The amount of translation in Y direction, Default is 0.0 and it will stay in the middle height of the screen
    open static var yTranslation: CGFloat = 0.0

    /// The amount of opacity of the content view controller.
    open static var contentViewControllerOpacity: CGFloat = 1.0
    
    /// Side menu view controller 
    open static var sideMenuViewController: UIViewController?

}
