//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Lion on 27/12/2018.
//  Copyright © 2018 Nicolas Lion. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var classicButton: UIButton!
    @IBOutlet private weak var reverseButton: UIButton!
    @IBOutlet private weak var squareButton: UIButton!
    @IBOutlet private weak var gridView: GridView!
    @IBOutlet private weak var swipeLabel: UILabel!
    @IBOutlet private weak var swipeIcon: UIImageView!
    @IBOutlet private weak var refreshButton: UIButton!
    
    // MARK: - Properties
    
    private var buttonClickedTag: Int?
    private var swipeGesture: UISwipeGestureRecognizer?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupImageForBotButtons()
        refreshButton.layer.cornerRadius = 15
        gridView.style = .classic
        classicButton.isSelected = true
        gridView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        if let gesture = swipeGesture {
        self.view.addGestureRecognizer(gesture)
        swipeGesture?.direction = .up
    }
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        if newCollection.verticalSizeClass == .regular {
            self.swipeLabel.text = "Swipe up to share"
            self.swipeGesture?.direction = .up
        } else if newCollection.verticalSizeClass == .compact {
            self.swipeLabel.text = "Swipe left to share"
            self.swipeGesture?.direction = .left
        }
    }
    
    // MARK: - Actions
    
    @objc private func didSwipe() {
        UIView.animate(withDuration: 0.5, animations: animateGridView) { (success) in
            self.share()
        }
    }

    @IBAction private func didTapClassicButton() {
        hideGridView()
        setupClassicView()
    }
    
    @IBAction private func didTapReverseButton() {
        hideGridView()
        setuptReverseView()
    }
    
    @IBAction private func didTapSquareButton() {
        hideGridView()
        setupSquareView()
    }
    
    @IBAction private func didTapRefreshButton() {
        hideGridView()
        gridView.refreshGridViewButtons()
    }
    
    // MARK: - Functions
    
    private func showAction() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.pickPhotoFromCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.pickPhotoFromLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func reverseAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.gridView.transform = CGAffineTransform.identity
        }
        swipeLabel.isHidden = false
        swipeIcon.isHidden = false
    }
    
    private func hideGridView() {
        UIView.animate(withDuration: 0.05, animations: {
            self.gridView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { (success) in
            self.showGridView()
        }
    }
    
    private func showGridView() {
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.gridView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    private func animateGridView() {
        if swipeGesture?.direction == .up {
            gridView.transform = CGAffineTransform(translationX: 0, y: -1500)
            swipeLabel.isHidden = true
            swipeIcon.isHidden = true
        } else if swipeGesture?.direction == .left {
            gridView.transform = CGAffineTransform(translationX: -1500, y: 0)
            swipeLabel.isHidden = true
            swipeIcon.isHidden = true
        }
    }
    
    private func share() {
        let itemToShare = gridView.asImage()
        let activityController = UIActivityViewController(activityItems: [itemToShare] as [UIImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: reverseAnimation)
    }
    
    private func setupImageForBotButtons() {
        classicButton.setImage(UIImage(named: "Selected"), for: .selected)
        reverseButton.setImage(UIImage(named: "Selected"), for: .selected)
        squareButton.setImage(UIImage(named: "Selected"), for: .selected)
    }
    
    private func setupClassicView() {
        gridView.style = .classic
        classicButton.isSelected = true
        reverseButton.isSelected = false
        squareButton.isSelected = false
    }
    
    private func setuptReverseView() {
        gridView.style = .reverse
        reverseButton.isSelected = true
        classicButton.isSelected = false
        squareButton.isSelected = false
    }
    
    private func setupSquareView() {
        gridView.style = .square
        squareButton.isSelected = true
        classicButton.isSelected = false
        reverseButton.isSelected = false
    }
    
    private func pickPhotoFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func pickPhotoFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func transformGridViewButtons(with tag: Int, image: UIImage) {
        if tag == gridView.topLeftButton.tag {
            gridView.topLeftButton.setImage(image, for: .normal)
        } else if tag == gridView.topRightButton.tag {
            gridView.topRightButton.setImage(image, for: .normal)
        } else if tag == gridView.botLeftButton.tag {
            gridView.botLeftButton.setImage(image, for: .normal)
        } else if tag == gridView.botRightButton.tag {
            gridView.botRightButton.setImage(image, for: .normal)
        }
    }
    
//    private func setImageForGridViewbutton(image: UIImage) {
//            gridView.topLeftButton.setImage(image, for: .selected)
//            gridView.topRightButton.setImage(image, for: .selected)
//            gridView.botLeftButton.setImage(image, for: .selected)
//            gridView.botRightButton.setImage(image, for: .selected)
//    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage,
            let buttonClickedTag = buttonClickedTag {
            transformGridViewButtons(with: buttonClickedTag, image: image)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: GridViewDelegate {
    func gridView(_ mainView: GridView, didSelectButton tag: Int) {
        buttonClickedTag = tag
        showAction()
    }
  
}
