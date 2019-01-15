//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Lion on 27/12/2018.
//  Copyright © 2018 Nicolas Lion. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    // Mark: - Outlets
    
    @IBOutlet weak var classicViewButton: UIButton!
    @IBOutlet weak var reverseViewbutton: UIButton!
    @IBOutlet weak var squareViewbutton: UIButton!
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var swipeUpLabel: UILabel!
    @IBOutlet weak var swipeicon: UIImageView!
    
    // Mark: - Properties
    
    let selected = UIImage(named: "Selected")
    let imagePicker = UIImagePickerController()
    var buttonClickedTag: Int?
    var swipeGesture: UISwipeGestureRecognizer?
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    // Mark: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.style = .classic
        classicViewButton.setImage(selected, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        self.view.addGestureRecognizer(swipeGesture!)
        swipeGesture?.direction = .up
    }
    
    // Mark: - Actions
    
    @objc func didSwipe() {
        UIView.animate(withDuration: 0.5, animations: animateMainView) { (success) in
            self.share()
        }
    }
    
    
    @objc func didTapButton(_ sender: UIButton) {
        buttonClickedTag = sender.tag
        pickPhotoFromLibrary()
        
    }
  
    @IBAction func didTapClassicViewButton() {
        setupClassicView()
    }
    
    @IBAction func didTapReverseViewButton() {
        setuptReverseView()
    }
    
    @IBAction func didTapSquareViewButton() {
        setupSquareView()
    }
    
    // Mark: - Functions
    
    private func reverseAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.mainView.transform = CGAffineTransform.identity
        }
        swipeUpLabel.isHidden = false
        swipeicon.isHidden = false
    }
    
    private func animateMainView() {
        if swipeGesture?.direction == .up {
            mainView.transform = CGAffineTransform(translationX: 0, y: -1500)
            swipeUpLabel.isHidden = true
            swipeicon.isHidden = true
        } else {
            mainView.transform = CGAffineTransform(translationX: -1500, y: 0)
            swipeUpLabel.isHidden = true
            swipeicon.isHidden = true
        }
    }
    
    private func share() {
        let itemToShare = [mainView]
        let activityController = UIActivityViewController(activityItems: itemToShare as [Any], applicationActivities: nil)
        self.present(activityController, animated: true, completion: reverseAnimation)
    }
    
    private func setupClassicView() {
        mainView.style = .classic
        classicViewButton.setImage(selected, for: .normal)
        reverseViewbutton.setImage(nil, for: .normal)
        squareViewbutton.setImage(nil, for: .normal)
    }
    
    private func setuptReverseView() {
        mainView.style = .reverse
        classicViewButton.setImage(nil, for: .normal)
        reverseViewbutton.setImage(selected, for: .normal)
        squareViewbutton.setImage(nil, for: .normal)
        
    }
    
    private func setupSquareView() {
        mainView.style = .square
        classicViewButton.setImage(nil, for: .normal)
        reverseViewbutton.setImage(nil, for: .normal)
        squareViewbutton.setImage(selected, for: .normal)
    }
    
    private func pickPhotoFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func transformButton(with tag: Int, image: UIImage) {
        if tag == mainView.topButton1.tag {
            mainView.topButton1.setImage(image, for: .normal)
        } else if tag == mainView.topButton2.tag {
            mainView.topButton2.setImage(image, for: .normal)
        } else if tag == mainView.botButton1.tag {
            mainView.botButton1.setImage(image, for: .normal)
        } else if tag == mainView.botButton2.tag {
            mainView.botButton2.setImage(image, for: .normal)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
        transformButton(with: buttonClickedTag!, image: image)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        DispatchQueue.main.async {
            if newCollection.verticalSizeClass == .regular {
                self.swipeUpLabel.text = "Swipe up to share"
                self.swipeGesture?.direction = .up
            } else {
                self.swipeUpLabel.text = "Swipe left to share"
                self.swipeGesture?.direction = .left
            }
        }
    }
    
}

