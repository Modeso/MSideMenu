//
//  PresentSideMenuSegue.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import UIKit

open class PresentSideMenuSegue: UIStoryboardSegue {

    fileprivate let transitionManager: SideMenuTransitionsManager = SideMenuTransitionsManager()

    override open func perform() {

        self.destination.transitioningDelegate = transitionManager
        self.source.present(self.destination, animated: true, completion: nil)

    }
}
