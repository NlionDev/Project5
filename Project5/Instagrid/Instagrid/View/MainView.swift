//
//  MainView.swift
//  Instagrid
//
//  Created by Nicolas Lion on 02/01/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import UIKit


class MainView: UIView {
    
    // Mark: - Outlets
    
   @IBOutlet var firstLineStackView: UIStackView!
   @IBOutlet var secondLineStackView: UIStackView!

    // Mark: - Properties
    
    let topButton1 = UIButton()
    let topButton2 = UIButton()
    let botButton1 = UIButton()
    let botButton2 = UIButton()
    let plus = UIImage(named: "Plus")
    
    var style: Style = .classic {
        didSet {
            setStyle(style)
        }
    }
    
    // Mark: - Enum
    
    enum Style {
        case classic
        case reverse
        case square
    }
 
    // Mark: - Functions
    
    func initButtonTag() {
        topButton1.tag = 1
        topButton2.tag = 2
        botButton1.tag = 3
        botButton2.tag = 4
    }
    
    func initAllButtons() {
        initButton(button: topButton1)
        initButton(button: topButton2)
        initButton(button: botButton1)
        initButton(button: botButton2)
    }

    private func setStyle(_ style: Style) {
        refresh()
        switch style {
        case .classic:
            setupButton(button: topButton1, in: firstLineStackView)
            setupButton(button: topButton2, in: firstLineStackView)
            setupButton(button: botButton1, in: secondLineStackView)
            
        case .reverse:
            setupButton(button: topButton1, in: firstLineStackView)
            setupButton(button: botButton1, in: secondLineStackView)
            setupButton(button: botButton2, in: secondLineStackView)
            
        case .square:
            setupButton(button: topButton1, in: firstLineStackView)
            setupButton(button: topButton2, in: firstLineStackView)
            setupButton(button: botButton1, in: secondLineStackView)
            setupButton(button: botButton2, in: secondLineStackView)
        }
    }
    
    private func initButton(button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setImage(plus, for: .normal)
        button.addTarget(ViewController(), action: #selector(ViewController.didTapButton), for: .touchUpInside)
       
    }
    
    private func setupButton(button: UIButton, in view: UIStackView) {
        view.addArrangedSubview(button)
    }
 
    private func refresh() {
        topButton1.removeFromSuperview()
        topButton2.removeFromSuperview()
        botButton1.removeFromSuperview()
        botButton2.removeFromSuperview()
    }
    
}

// MARK: - Extension

extension MainView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
            layer.render(in: rendererContext.cgContext)
        })
    }
}


