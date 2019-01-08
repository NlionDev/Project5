//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Lion on 27/12/2018.
//  Copyright © 2018 Nicolas Lion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
   
    @IBOutlet weak var classicViewButton: UIButton!
    @IBOutlet weak var reverseViewbutton: UIButton!
    @IBOutlet weak var squareViewbutton: UIButton!
    @IBOutlet weak var mainView: MainView!
    
    let selected = UIImage(named: "Selected")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.style = .classic
        classicViewButton.setImage(selected, for: .normal)
    }
    
    @IBAction func didTapClassicViewButton() {
        setupClassicView()
    }
    
    private func setupClassicView() {
        mainView.refresh()
        mainView.style = .classic
        classicViewButton.setImage(selected, for: .normal)
        reverseViewbutton.setImage(nil, for: .normal)
        squareViewbutton.setImage(nil, for: .normal)
    }
    
    @IBAction func didTapReverseViewButton() {
        setuptReverseView()
    }
    
    private func setuptReverseView() {
        mainView.refresh()
        mainView.style = .reverse
        classicViewButton.setImage(nil, for: .normal)
        reverseViewbutton.setImage(selected, for: .normal)
        squareViewbutton.setImage(nil, for: .normal)
    }
    
    @IBAction func didTapSquareViewButton() {
        setupSquareView()
    }
    
    private func setupSquareView() {
        mainView.refresh()
        mainView.style = .square
        classicViewButton.setImage(nil, for: .normal)
        reverseViewbutton.setImage(nil, for: .normal)
        squareViewbutton.setImage(selected, for: .normal)
    }
    
    @IBAction func didTapTopLeftButton() {
        
    }
    
   
}

