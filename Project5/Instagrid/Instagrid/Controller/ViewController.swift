//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Lion on 27/12/2018.
//  Copyright © 2018 Nicolas Lion. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
   
    @IBOutlet weak var classicViewButton: UIButton!
    @IBOutlet weak var reverseViewbutton: UIButton!
    @IBOutlet weak var squareViewbutton: UIButton!
    @IBOutlet weak var mainView: MainView!
    
    let selected = UIImage(named: "Selected")
    let imagePicker = UIImagePickerController()
    var choosenImage = UIImageView()
    var buttonClicked = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.style = .classic
        classicViewButton.setImage(selected, for: .normal)
        
        let topSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeTop))
        topSwipeGesture.direction = .up
        self.view.addGestureRecognizer(topSwipeGesture)
    }
    
    @objc func didSwipeTop() {
        
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
    
    private func pickPhotoFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
 
    @objc func didTapButton(_ sender: UIButton) {
        buttonClicked = sender
        pickPhotoFromLibrary()
       
    }
    
    private func transformButton(_ sender: AnyObject?) {
        if sender === mainView.topButton1 {
            mainView.topButton1.setImage(choosenImage.image, for: .normal)
        } else if sender === mainView.topButton2 {
            mainView.topButton2.setImage(choosenImage.image, for: .normal)
        } else if sender === mainView.botButton1 {
            mainView.botButton1.setImage(choosenImage.image, for: .normal)
        } else if sender === mainView.botButton2 {
            mainView.botButton2.setImage(choosenImage.image, for: .normal)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        choosenImage.image = image
        transformButton(buttonClicked)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

