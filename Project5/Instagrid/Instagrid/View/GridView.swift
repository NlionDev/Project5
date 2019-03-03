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
    
    private let topLeftButton = UIButton()
    private let topRightButton = UIButton()
    private let botLeftButton = UIButton()
    private let botRightButton = UIButton()
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
        addButtonsInStackViews()
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
 
    // MARK: - Public Methods
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
            layer.render(in: rendererContext.cgContext)
        })
    }
    
    func setImage(_ image: UIImage, with tag: Int) {
        if tag == topLeftButton.tag {
            topLeftButton.setImage(image, for: .normal)
        } else if tag == topRightButton.tag {
            topRightButton.setImage(image, for: .normal)
        } else if tag == botLeftButton.tag {
            botLeftButton.setImage(image, for: .normal)
        } else if tag == botRightButton.tag {
            botRightButton.setImage(image, for: .normal)
        }
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

    // MARK: - Private Methods
    
    private func setStyle(_ style: Style) {
        switch style {
        case .classic:
            topLeftButton.isHidden = false
            topRightButton.isHidden = false
            botLeftButton.isHidden = false
            botRightButton.isHidden = true
            
        case .reverse:
            topLeftButton.isHidden = false
            topRightButton.isHidden = true
            botLeftButton.isHidden = false
            botRightButton.isHidden = false
            
        case .square:
            topLeftButton.isHidden = false
            topRightButton.isHidden = false
            botLeftButton.isHidden = false
            botRightButton.isHidden = false
        }
    }
    
    private func configureGridViewButton(button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setImage(UIImage(named: "Plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupGridViewButtonsTag() {
        topLeftButton.tag = 1
        topRightButton.tag = 2
        botLeftButton.tag = 3
        botRightButton.tag = 4
    }
    
    private func addButtonsInStackViews() {
        firstLineStackView.addArrangedSubview(topLeftButton)
        firstLineStackView.addArrangedSubview(topRightButton)
        secondLineStackView.addArrangedSubview(botLeftButton)
        secondLineStackView.addArrangedSubview(botRightButton)
    }
}



