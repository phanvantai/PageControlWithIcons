//
//  CustomPageControl.swift
//  PageControl
//
//  Created by Tai Phan Van on 11/05/2021.
//

import UIKit

struct CustomPageModel {
    var index: Int?
    var iconLink: String?
    var webLink: String?
    
    func button() -> UIButton {
        let button = UIButton()
        button.tintColor = .cyan
        button.setImage(UIImage(named: "home")?.withRenderingMode(.alwaysTemplate), for: .selected)
        button.setImage(UIImage(named: "home"), for: .normal)
        return button
    }
}

protocol CustomPageControlDelegate {
    func selected(index: Int)
}

class CustomPageControl: NSObject {
    
    // MARK: - View
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 0
        view.distribution = .fillEqually
        view.alignment = .center
        return view
    }()
    lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }()
    
    var delegate: CustomPageControlDelegate?
    
    init(pages: [CustomPageModel]) {
        super.init()
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0.0),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.widthAnchor.constraint(equalToConstant: CGFloat(60 * pages.count)),
        ])
        
        let buttons = pages.map({ return $0.button() })
        buttons.forEach({ button in
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(onButtonTapped(sender:)), for: .touchUpInside)
        })
    }
    
    func select(index: Int) {
        guard let buttons = stackView.subviews as? [UIButton] else { return }
        _ = buttons.enumerated().map{ (idx, button) in
            button.isSelected = idx == index
        }
    }
    
    @objc func onButtonTapped(sender: UIButton) {
        guard let buttons = stackView.subviews as? [UIButton] else { return }
        for button in buttons {
            button.isSelected = button == sender
        }
        delegate?.selected(index: stackView.subviews.firstIndex(of: sender) ?? 0)
    }
}
