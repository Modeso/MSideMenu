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
        - Just use this navigation controller as entery point and it should has a root view controller, and specify the sideMenuViewController.
 */
open class SideMenuNavigationController: UINavigationController {

    /// The side menu Image
    @IBInspectable open var sideMenuImage: UIImage?
    
    /// Duration of the animation that the menu needs to be presented. Default is 0.35 seconds.
    @IBInspectable open var presentationDuration: Double  = 0.35
    
    /// Duration of the animation that the menu needs to be dismissed. Default is 0.35 seconds.
    @IBInspectable open var dismissDuration: Double  = 0.35
    
    /// The scale of the content view controller
    @IBInspectable open var contentViewControllerScale: CGFloat = 0.5
    
    /// Value for the scale of the left side menu while dismissing and presenting
    @IBInspectable open var leftSideMenuViewControllerScale: Float = 1.2

    
    /// The amount of translation in X direction, Value 0.0 will stay in the middle of the screen
    @IBInspectable open var xTranslation: CGFloat  = 0.5
    
    
    /// The amount of translation in Y direction, Default is 0.0 and it will stay in the middle of the screen
    @IBInspectable open var yTranslation: CGFloat  = 0.0
    
    
    /// The amount of opacity of the content view controller.
    @IBInspectable open var contentViewControllerOpacity: CGFloat = 1.0
    
    
    /// Handle if tapping in the animated content view controller should dismiss the side menu or not
    @IBInspectable open var shouldDismissOnTappingContentVC: Bool  = true
    
    
    /// Handle if the content view controller will have shadow or not
    @IBInspectable open var contentViewHasShadow: Bool = true
    
    
    /// Color of the shadow of the content view controller
    @IBInspectable open var contentViewShadowColor: UIColor = UIColor.black
    
    
    /// Offset of the shadow of the content view controller
    @IBInspectable open var contentViewShadowOffset: CGSize = .zero
    
    
    /// Opacity of the shadow of the content view controller
    @IBInspectable open var contentViewShadowOpacity: Float = 1.0
    
    
    /// Radius of the shadow of the content view controller
    @IBInspectable open var contentViewShadowRadius: Float = 10.0
    
    /// Value for the Spring with Damping for Presentation animation
    @IBInspectable open var presentationAnimationSpringWithDamping: Float = 0.5
    
    
    /// Value for the Initial Spring Velocity for presentation Animation
    @IBInspectable open var presentationAnimationInitialSpringVelocity: Float = 0.5
    
    
    /// Value for the Spring with Damping for Dismissal animation
    @IBInspectable open var dismissAnimationSpringWithDamping: Float = 1.0
    
    
    /// Value for the Initial Spring Velocity for Dismissal Animation
    @IBInspectable open var dismissAnimationInitialSpringVelocity: Float = 1.0

    
    /// Side Menu View Controller
    open var sideMenuViewController: UIViewController?

    // MARK: - Private Properties

    /// transitionDelegate: Custom transition manager to mange the custom Modal transition for the side menu.
    let transitionDelegate: SideMenuTransitionsManager = SideMenuTransitionsManager()
    
    /// tapGesture: gesture recognizer to handle dismissing the menu on Clicking on the content view controller.
    var tapGesture: UITapGestureRecognizer?

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

