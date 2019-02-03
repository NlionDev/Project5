//
//  MainView.swift
//  Instagrid
//
//  Created by Nicolas Lion on 02/01/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import UIKit



protocol GridViewDelegate: class {
    func gridView(_ gridView: GridView, didSelectButton tag: Int)
}

class GridView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet private var firstLineStackView: UIStackView!
    @IBOutlet private var secondLineStackView: UIStackView!

    // MARK - Properties
    
    let topLeftButton = UIButton()
    let topRightButton = UIButton()
    let botLeftButton = UIButton()
    let botRightButton = UIButton()
    weak var delegate: GridViewDelegate?
    
    var style: Style = .classic {
        didSet {
            setStyle(style)
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupGridViewButtonsTag()
        configureAllGridViewButtons()
    }
    
    // MARK: - Enum
    
    enum Style {
        case classic
        case reverse
        case square
    }
    
    // MARK: - Actions
    
    @objc private func didTapButton(_ sender: UIButton) {
        delegate?.gridView(self, didSelectButton: sender.tag)
    }
 
    // MARK: - Public Functions
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
            layer.render(in: rendererContext.cgContext)
        })
    }
    
    func configureAllGridViewButtons() {
        configureGridViewButton(button: topLeftButton)
        configureGridViewButton(button: topRightButton)
        configureGridViewButton(button: botLeftButton)
        configureGridViewButton(button: botRightButton)
    }
    
    func refreshGridViewButtons() {
        topLeftButton.isSelected = false
        topRightButton.isSelected = false
        botLeftButton.isSelected = false
        botRightButton.isSelected = false
    }

    // MARK: - Private Functions
    
    private func setStyle(_ style: Style) {
        removeButtons()
        switch style {
        case .classic:
            setupButton(button: topLeftButton, in: firstLineStackView)
            setupButton(button: topRightButton, in: firstLineStackView)
            setupButton(button: botLeftButton, in: secondLineStackView)
            
        case .reverse:
            setupButton(button: topLeftButton, in: firstLineStackView)
            setupButton(button: botLeftButton, in: secondLineStackView)
            setupButton(button: botRightButton, in: secondLineStackView)
            
        case .square:
            setupButton(button: topLeftButton, in: firstLineStackView)
            setupButton(button: topRightButton, in: firstLineStackView)
            setupButton(button: botLeftButton, in: secondLineStackView)
            setupButton(button: botRightButton, in: secondLineStackView)
        }
    }
    
    private func configureGridViewButton(button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setImage(UIImage(named: "Plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func removeButtons() {
        topLeftButton.removeFromSuperview()
        topRightButton.removeFromSuperview()
        botLeftButton.removeFromSuperview()
        botRightButton.removeFromSuperview()
    }
    
    private func setupButton(button: UIButton, in view: UIStackView) {
        view.addArrangedSubview(button)
    }
    
    private func setupGridViewButtonsTag() {
        topLeftButton.tag = 1
        topRightButton.tag = 2
        botLeftButton.tag = 3
        botRightButton.tag = 4
    }
    
}



