//
//  ExampleViewController.swift
//  PageControl
//
//  Created by Tai Phan Van on 08/05/2021.
//

import UIKit

// simple example view controller
// has a label 90% of the width, centered X and Y
class ExampleViewController: UIViewController {

    let theLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.textAlignment = .center
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(theLabel)
        NSLayoutConstraint.activate([
            theLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            theLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            theLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            ])

    }

}
