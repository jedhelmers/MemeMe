//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Jesse Helmers on 1/1/20.
//  Copyright © 2020 Jesse Helmers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var saveMemeButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setup()
    }
    
    func setup() {
        self.topTextField.text = "TOP"
        self.bottomTextField.text = "BOTTOM"
        self.imagePickerView.image = nil
        self.saveMemeButton.isEnabled = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isEditing{
        view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        super.touchesBegan(touches, with: event)
        self.topTextField.resignFirstResponder()
        self.bottomTextField.resignFirstResponder()
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func generateMemedImage() -> UIImage {
        
        hiddenToolBarNavBar(showOption: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        hiddenToolBarNavBar(showOption: false)
        
        return memeImage
    }
    
    func hiddenToolBarNavBar(showOption: Bool) {
        self.toolbar.isHidden = showOption
        self.navigationBar.isHidden = showOption
    }
    
    func save(_ memeImg: UIImage) {
        _ = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, image: self.imagePickerView.image!, memeImage: memeImg)
    }
    
    func chooseSourceType(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .scaleAspectFill
            self.saveMemeButton.isEnabled = true
        } else if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .scaleAspectFit
            self.saveMemeButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        chooseSourceType(sourceType: .photoLibrary)
    }
    
    @IBAction func takeAnImage(_ sender: UIBarButtonItem) {
        chooseSourceType(sourceType: .camera)
    }
    
    @IBAction func saveMemeAction(_ sender: UIBarButtonItem) {
        let memeImg = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memeImg], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            activity, completed, item, error in
            if completed {
                self .save(memeImg)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.setup()
    }
}

