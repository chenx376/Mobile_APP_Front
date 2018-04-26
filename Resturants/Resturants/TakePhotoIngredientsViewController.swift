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
            
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imageData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
//            },to:"172.29.95.188/test")
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//
//                    upload.responseJSON { response in
//                        print(response.result.value!)
//                    }
//
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }
            
            
            let imageString = imageData.base64EncodedString(options: .endLineWithLineFeed)
            let parameters:[String: String] = [
                "image":imageString
            ]
            
            
            
//            Alamofire.upload(imageData.base64EncodedData(options: .endLineWithLineFeed), to: "http://172.29.95.188:8585/shopping")
//                .validate()
            Alamofire.request("http://172.29.94.19:8585/shopping", method: .post,parameters: parameters, encoding: URLEncoding.httpBody)
                .responseJSON { response in
                    if let data = response.data, let sp = try? JSONDecoder().decode([ShoppingItem].self, from: data){
                        if sp.count > 0 {
                            self.shoppingItems = sp
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
