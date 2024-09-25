//
//  NavigationController.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import UIKit

final class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Life Cycle Mthods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        customizeNavigationTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func customizeNavigationTitle() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: .bold),
                                             NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: .bold),
                                                  NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationBar.barStyle = .default
        navigationBar.barTintColor = .systemBackground
        navigationBar.tintColor = .label
    }
    
    
    //MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
