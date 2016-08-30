//
//  ViewController.swift
//  Meme Me Version 1
//
//  Created by Warren Hansen on 8/27/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: struct for meme data model
    struct Meme {
        var topTextField: String!
        var bottomtextFiield: String!
        var originalImage: UIImage!
        var memedImage: UIImage!
        
        init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
            self.topTextField = top
            self.bottomtextFiield = bottom
            self.originalImage = image
            self.memedImage = memedImage
        }
    }
    
    // MARK: textfield attributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0 ]
    
    // MARK: UIImage and text vars
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomtextFiield: UITextField!
    
    // MARK: pick image or camera
    @IBAction func pickAnImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func showCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
    }
    
    // MARK: share generated image
    @IBAction func shareItems(sender: AnyObject) {
        print("We Share then save")
        let ac = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        ac.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
                print("Successful save from share func")
            }
        }
        presentViewController(ac, animated: true, completion: nil)
    }
    
    // MARK: cancel image selection
    @IBAction func cancelMainScreen(sender: AnyObject) {
        imagePickerView.image = nil
        topTextField.text = "top"
        bottomtextFiield.text = "bottom"
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        print("Image Picker Cancel")
    }
    
    // MARK:  defualt text field attributes
    func setUpTextFields() {
        topTextField.text = "Top"
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.delegate = self
        topTextField.textAlignment = .Center
        
        bottomtextFiield.text = "Bottom"
        bottomtextFiield.defaultTextAttributes = memeTextAttributes
        bottomtextFiield.delegate = self
        bottomtextFiield.textAlignment = .Center
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textFieldDidBeginEditing")
        if topTextField.text == "Top" || bottomtextFiield.text == "Bottom" {
            textField.text = ""
        }
    }
    
    // MARK: lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        setUpTextFields()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        print("View Did Appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unSubscribeToKeyboardNotofications()
    }
    
    // MARK: get  original or edited image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        print("We chose an Image")
        imagePickerView.image = newImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:  NSNotification subscriptions and selectors
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unSubscribeToKeyboardNotofications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // MARK: shift the view's frame up only on bottom text field
    func keyboardWillShow(notification: NSNotification) {
        if bottomtextFiield.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomtextFiield.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: hide keyboard with return or on click away from text
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: save + generate meme
    func save() {
        _ = Meme(top: topTextField.text!, bottom: bottomtextFiield.text!, image: imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage
    {
        toolBarVisible(false)    // Hide toolbar and navbar
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBarVisible(true)
        
        return memedImage
    }
    
    func toolBarVisible(visible: Bool){
        if !visible {
            self.navigationController?.navigationBarHidden = true
            self.navigationController?.toolbarHidden = true
        } else {
            self.navigationController?.navigationBarHidden = false
            self.navigationController?.toolbarHidden = false
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}