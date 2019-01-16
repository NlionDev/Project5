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
    // Mark: - Actions
    

    
    // Mark: - Functions

    private func setStyle(_ style: Style) {
        refresh()
        switch style {
        case .classic:
            setupTopButton1()
            setupTopButton2()
            setupBotButton1()
            
        case .reverse:
            setupTopButton1()
            setupBotButton1()
            setupBotButton2()

        case .square:
            setupTopButton1()
            setupTopButton2()
            setupBotButton1()
            setupBotButton2()
        }
    }
    
    private func setupTopButton1() {
        firstLineStackView.addArrangedSubview(topButton1)
        topButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        topButton1.tag = 1
        topButton1.setImage(plus, for: .normal)
        topButton1.addTarget(ViewController(), action: #selector(ViewController.didTapButton), for: .touchUpInside)
    }
    
    private func setupTopButton2() {
        firstLineStackView.addArrangedSubview(topButton2)
        topButton2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        topButton2.tag = 2
        topButton2.setImage(plus, for: .normal)
        topButton2.addTarget(ViewController(), action: #selector(ViewController.didTapButton), for: .touchUpInside)
    }
    
    private func setupBotButton1() {
        secondLineStackView.addArrangedSubview(botButton1)
        botButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        botButton1.tag = 3
        botButton1.setImage(plus, for: .normal)
        botButton1.addTarget(ViewController(), action: #selector(ViewController.didTapButton), for: .touchUpInside)
    }
    
    private func setupBotButton2() {
        secondLineStackView.addArrangedSubview(botButton2)
        botButton2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        botButton2.tag = 4
        botButton2.setImage(plus, for: .normal)
        botButton2.addTarget(ViewController(), action: #selector(ViewController.didTapButton), for: .touchUpInside)
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


