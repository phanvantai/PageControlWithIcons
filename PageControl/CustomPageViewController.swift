//
//  CustomPageViewController.swift
//  PageControl
//
//  Created by Tai Phan Van on 08/05/2021.
//

import UIKit

// example Page View Controller
class CustomPageViewController: UIPageViewController {
    
    let colors: [UIColor] = [
        .red,
        .green,
        .blue,
        .yellow,
        .orange
    ]
    
    weak var customDelegate: CustomPageViewControllerDelegate?

    var pages: [UIViewController] = [UIViewController]()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        // instantiate "pages"
        for i in 0..<colors.count {
            let vc = ExampleViewController()
            vc.theLabel.text = "Page: \(i)"
            vc.view.backgroundColor = colors[i]
            pages.append(vc)
        }

        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }

    func goToPage(index: Int) {
        let currentViewController = viewControllers!.first!
        let currentViewControllerIndex = pages.firstIndex(of: currentViewController)!

        let direction: NavigationDirection = index > currentViewControllerIndex ? .forward : .reverse
        setViewControllers([pages[index]], direction: direction, animated: true, completion: nil)
    }
}

// typical Page View Controller Data Source
extension CustomPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}

// typical Page View Controller Delegate
extension CustomPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPageViewController = pageViewController.viewControllers?.first as? ExampleViewController {
            let index = pages.firstIndex(of: currentPageViewController)!
            customDelegate?.pageChangedTo(index: index)
        }
    }
}

protocol CustomPageViewControllerDelegate: AnyObject {
    func pageChangedTo(index: Int)
}
