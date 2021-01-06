//
//  CarImagePicker.swift
//  MyGarage
//
//  Created by mac on 06.01.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

extension CarViewController: ImagePickerDelegate {

    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        if self.nameView != nil {
            self.nameView?.carImageView.image = image
        }
//        imageView.image = image
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss() }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
}
