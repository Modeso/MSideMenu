//
//  FirstViewController.swift
//  MSideMenu
//
//  Created by esraaapady on 03/23/2017.
//  Copyright (c) 2017 esraaapady. All rights reserved.
//

import UIKit
import MSideMenu

class FirstViewController: UIViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
        // configure the side menu
        guard let sideMenuNavController = self.navigationController as? SideMenuNavigationController else {
            return
        }
        sideMenuNavController.leftSideMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leftSideViewController")
        sideMenuNavController.rightSideMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rightSideViewController")

    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

