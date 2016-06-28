//
//  CropImage.swift
//  patnactka
//
//  Created by Radim Langer on 17/06/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//


import UIKit

class CropImageToParts {
    
    var imageStack = [CGImage]()
    var cropImage = UIImage()
    
    
    init() {
        initializeImage()
        cropImagePutToArray()
    }
    
    
    func initializeImage() {
        cropImage = UIImage(named: "nickCrop.png")!
    }
    
    
    func cropImagePutToArray() {
        
        let scale = cropImage.scale
        
        let imageSize = CGSizeMake(cropImage.size.width/scale, cropImage.size.height/scale)
//  4x4 cropping
        for rowI in 0...3
        {
            for colI in 0...3
            {
                let imageSizeRect = CGRectMake(CGFloat(colI) * imageSize.width, CGFloat(rowI) * imageSize.height, imageSize.width, imageSize.height)

                let onePieceImage = CGImageCreateWithImageInRect(cropImage.CGImage, imageSizeRect)
                imageStack.append(onePieceImage!)
                
            }
        }
    }
    

    
}