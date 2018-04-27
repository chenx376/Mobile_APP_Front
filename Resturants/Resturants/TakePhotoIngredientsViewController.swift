//
//  TakePhotoIngredientsViewController.swift
//  Resturants
//
//  Created by Mark on 4/25/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit
import Alamofire

class TakePhotoIngredientsViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var usePhotoButton: UIButton!
    @IBOutlet weak var uploadActivityIndicatorView: UIActivityIndicatorView!
    
    var photo: UIImage?
    var shoppingItems: [ShoppingItem]?
    var response: ShoppingResponse?
    
    @IBAction func takePhoto(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func usePhoto(_ sender: UIButton) {
        if let photo = photo, let imageData = UIImageJPEGRepresentation(photo, 0.1) {
            takePhotoButton.isEnabled = false
            usePhotoButton.isEnabled = false
            uploadActivityIndicatorView.startAnimating()
            
            
            let imageString = imageData.base64EncodedString(options: .endLineWithLineFeed)
            let parameters:[String: String] = [
                "image":imageString
            ]
            

            Alamofire.request("http://35.231.62.8:80/shopping", method: .post,parameters: parameters, encoding: URLEncoding.httpBody)
                .responseJSON { response in
                    if let data = response.data, let response = try? JSONDecoder().decode(ShoppingResponse.self, from: data){
                        self.response = response
                        
                        if response.ingredients.count > 0{
                           self.shoppingItems = response.ingredients
                        } else {
                            self.shoppingItems = [ShoppingItem("Can't find any ingredients")]
                        }
                        self.performSegue(withIdentifier: "showShoppingList", sender: self)

                    }
                    self.takePhotoButton.isEnabled = true
                    self.usePhotoButton.isEnabled = true
                    self.uploadActivityIndicatorView.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? ShoppingListViewController)?.shoppingItems = shoppingItems
        (segue.destination as? ShoppingListViewController)?.response = response
    }
    
}

extension TakePhotoIngredientsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoImageView.image = photo
        takePhotoButton.setTitle("Retake Photo", for: .normal)
        usePhotoButton.isHidden = false
    }
    
}
