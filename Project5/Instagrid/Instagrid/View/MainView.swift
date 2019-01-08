//
//  MainView.swift
//  Instagrid
//
//  Created by Nicolas Lion on 02/01/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import UIKit

class MainView: UIView {

   @IBOutlet private var firstLineStackView: UIStackView!
   @IBOutlet private var secondLineStackView: UIStackView!

    let topButton1 = UIButton()
    let topButton2 = UIButton()
    let botButton1 = UIButton()
    let botButton2 = UIButton()
    
    let plus = UIImage(named: "Plus")
    
    enum Style {
        case classic
        case reverse
        case square
    }
    
    
    var style: Style = .classic {
        didSet {
            setStyle(style)
        }
    }
    
    
    private func setStyle(_ style: Style) {
        switch style {
        case .classic:
            firstLineStackView.addArrangedSubview(topButton1)
            topButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            topButton1.setImage(plus, for: .normal)
            firstLineStackView.addArrangedSubview(topButton2)
            topButton2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            topButton2.setImage(plus, for: .normal)
            secondLineStackView.addArrangedSubview(botButton1)
            botButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            botButton1.setImage(plus, for: .normal)
        case .reverse:
            firstLineStackView.addArrangedSubview(topButton1)
            topButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            topButton1.setImage(plus, for: .normal)
            secondLineStackView.addArrangedSubview(botButton1)
            botButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            botButton1.setImage(plus, for: .normal)
            secondLineStackView.addArrangedSubview(botButton2)
            botButton2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            botButton2.setImage(plus, for: .normal)
        case .square:
            firstLineStackView.addArrangedSubview(topButton1)
            topButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            topButton1.setImage(plus, for: .normal)
            firstLineStackView.addArrangedSubview(topButton2)
            topButton2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            topButton2.setImage(plus, for: .normal)
            secondLineStackView.addArrangedSubview(botButton1)
            botButton1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            botButton1.setImage(plus, for: .normal)
            secondLineStackView.addArrangedSubview(botButton2)
            botButton2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            botButton2.setImage(plus, for: .normal)
            
        }
    }
    
    func refresh() {
        
        topButton1.removeFromSuperview()
        topButton2.removeFromSuperview()
        botButton1.removeFromSuperview()
        botButton2.removeFromSuperview()
    }
    
    
}
