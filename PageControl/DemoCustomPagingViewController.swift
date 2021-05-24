//
//  DemoCustomPagingViewController.swift
//  PageControl
//
//  Created by Tai Phan Van on 08/05/2021.
//

import UIKit

class DemoCustomPagingViewController: UIViewController {

    var pageViewController: CustomPageViewController!
    var pageControl: CustomPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageController()
        setupPageControl()
    }
    
    func setupPageController() {
        // instantiate MyPageViewController and add it as a Child View Controller
        pageViewController = CustomPageViewController()
        pageViewController.customDelegate = self
        addChild(pageViewController)

        // we need to re-size the page view controller's view to fit our container view
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        // add the page VC's view to our container view
        view.addSubview(pageViewController.view)

        // constrain it to all 4 sides
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
        ])

        pageViewController.didMove(toParent: self)
    }

    func setupPageControl() {
        print(#function)
        var icons = [CustomPageModel]()
        for _ in 0..<pageViewController.pages.count {
            icons.append(CustomPageModel())
        }
        pageControl = CustomPageControl(pages: icons)
        pageControl.delegate = self
        pageControl.select(index: 0)
        
        view.addSubview(pageControl.view)
        NSLayoutConstraint.activate([
            pageControl.view.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
            pageControl.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0),
        ])
    }
}

extension DemoCustomPagingViewController: CustomPageViewControllerDelegate {
    func pageChangedTo(index: Int) {
        pageControl.select(index: index)
    }
}

extension DemoCustomPagingViewController: CustomPageControlDelegate {
    func selected(index: Int) {
        pageViewController.goToPage(index: index)
    }
}
