//
//  TakePhotoViewController.swift
//  Resturants
//
//  Created by qin on 4/21/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit
import Alamofire

class TakePhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var usePhotoButton: UIButton!
    @IBOutlet weak var uploadActivityIndicatorView: UIActivityIndicatorView!
    
    var photo: UIImage?
    var resturants: [Resturant]?
    
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
            Alamofire.upload(imageData.base64EncodedData(), to: "http://10.0.0.71:8585/photo")
                .validate()
                .responseData { response in
                    if let data = response.data, let resturants = try? JSONDecoder().decode([Resturant].self, from: data) {
                        self.resturants = resturants
                        self.performSegue(withIdentifier: "showSearchResults", sender: self)
                    }
                    self.takePhotoButton.isEnabled = true
                    self.usePhotoButton.isEnabled = true
                    self.uploadActivityIndicatorView.stopAnimating()
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? SearchResultsViewController)?.resturants = resturants
    }
    
}

extension TakePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoImageView.image = photo
        takePhotoButton.setTitle("Retake Photo", for: .normal)
        usePhotoButton.isHidden = false
    }
    
}
