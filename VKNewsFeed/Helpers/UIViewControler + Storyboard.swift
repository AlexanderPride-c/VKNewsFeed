//
//  UIViewControler + Storyboard.swift
//  VKNewsFeed
//
//  Created by Александр Прайд on 23.09.2020.
//  Copyright © 2020 Alexander Pride. All rights reserved.
//

import UIKit

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
}
