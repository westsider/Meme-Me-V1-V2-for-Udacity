//
//  MemeEditorViewController
//  Meme Me Version 2 Branch from Version 1
//
//  Created by Warren Hansen on 8/27/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//  Change aspect fit in collections to show whole image

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: UIImage and text vars
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomtextFiield: UITextField!
    
    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var toolBat: UIToolbar!
    
    var memedImage: UIImage!
    
    // MARK: pick image or camera
    func pickImage(source: UIImagePickerControllerSourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        presentViewController(pickerController, animated: true, completion: nil)
    }
    @IBAction func pickAnImage(sender: AnyObject) {
        pickImage(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func showCamera(sender: AnyObject) {
        pickImage(UIImagePickerControllerSourceType.Camera)
    }
    
    // MARK: share generated image
    @IBAction func shareItems(sender: AnyObject) {
        
        let memeToShare = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.safelySaveMeme(memeToShare)
            }
        }
        presentViewController(activityViewController, animated: true, completion: nil)
    }

    // MARK: cancel image selection
    @IBAction func cancelMainScreen(sender: AnyObject) {
        imagePickerView.image = nil
        topTextField.text = "TOP"
        bottomtextFiield.text = "BOTTOM"
        dismissViewControllerAnimated(true, completion: {}) // removed self
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:  defualt text field attributes
    func setTextFields(textInput: UITextField!, defaultText: String) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0 ]
        textInput.text = defaultText
        textInput.defaultTextAttributes = memeTextAttributes
        textInput.delegate = self
        textInput.textAlignment = .Center
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if topTextField.text == "TOP" || bottomtextFiield.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        setTextFields(topTextField, defaultText: "TOP")
        setTextFields(bottomtextFiield, defaultText: "BOTTOM")
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
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
        
        imagePickerView.image = newImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:  NSNotification subscriptions and selectors
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unSubscribeToKeyboardNotofications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: shift the view's frame up only on bottom text field
    func keyboardWillShow(notification: NSNotification) {
        if bottomtextFiield.isFirstResponder() && view.frame.origin.y == 0.0{
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
        view.endEditing(true)   // removed self
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)   // removed self
    }
    
    // MARK: generate meme + save
    func generateMemedImage() -> UIImage {
        
        toolBarVisible(false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBarVisible(true)
        
        return memedImage
    }
    func safelySaveMeme(memedImage: UIImage) {
        // safely unwrap optionals
        if imagePickerView.image != nil && topTextField.text != nil && bottomtextFiield.text != nil
        {
            let top = self.topTextField.text!
            let bottom = self.bottomtextFiield.text!
            let image = self.imagePickerView.image!
            
            let meme = Meme(topTextField: top, bottomtextFiield: bottom, originalImage: image, memedImage: memedImage)
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        }
    }
    
    // MARK: toolbar functions
    func toolBarVisible(visible: Bool){
        if !visible {
            navBar.hidden = true    // removed self
            toolBat.hidden = true // typo on var for toolbar // removed self
        } else {
            navBar.hidden = false   // removed self
            toolBat.hidden = false  // removed self
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}