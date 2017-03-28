//
//  SideMenuManager.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import Foundation

/**
    SideMenuManager:
        - Manager class to handle configuration for the side menu. Now it supports Left side menu navigation only.
        - It has some parameters to control the position of the menu in the screen
        - The sideMenuViewController property should be set with the view controller that will appear in the left side
 */
open class SideMenuManager {

    /// Duration of the animation that the menu needs to be presented. Default is 0.35 seconds.
    open static var presentationDuration: Double = 0.5
    
    /// Duration of the animation that the menu needs to be dismissed. Default is 0.35 seconds.
    open static var dismissDuration: Double = 0.35

    /// The scale of the content view controller
    open static var contentViewControllerScale: CGFloat = 0.5

    /// The amount of translation in X direction, Default is 0.0 and it will stay in the middle of the screen
    open static var xTranslation: CGFloat = 0.5
    
    /// The amount of translation in Y direction, Default is 0.0 and it will stay in the middle of the screen
    open static var yTranslation: CGFloat = 0.0

    /// The amount of opacity of the content view controller.
    open static var contentViewControllerOpacity: CGFloat = 1.0
    
    /// Side menu view controller 
    open static var sideMenuViewController: UIViewController?

    /// Handle if tapping in the animated content view controller should dismiss the side menu or not
    open static var shouldDismissOnTappingContentVC: Bool = true

    /// Handle if the content view controller will have shadow or not
    open static var contentViewHasShadow: Bool = true

    /// Color of the shadow of the content view controller
    open static var contentViewShadowColor: UIColor = UIColor.black

    /// Offset of the shadow of the content view controller
    open static var contentViewShadowOffset: CGSize = .zero

    /// Opacity of the shadow of the content view controller
    open static var contentViewShadowOpacity: Float = 1.0
    
    /// Radius of the shadow of the content view controller
    open static var contentViewShadowRadius: Float = 50.0
    
    /// Value for the Spring with Damping for Presentation animation
    open static var presentationAnimationSpringWithDamping: Float = 0.5

    /// Value for the Initial Spring Velocity for presentation Animation
    open static var presentationAnimationInitialSpringVelocity: Float = 0.5

    /// Value for the Spring with Damping for Dismissal animation
    open static var dismissAnimationSpringWithDamping: Float = 1.0
    
    /// Value for the Initial Spring Velocity for Dismissal Animation
    open static var dismissAnimationInitialSpringVelocity: Float = 1.0


}
