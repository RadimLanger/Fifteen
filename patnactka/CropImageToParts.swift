//
//  CropImage.swift
//  patnactka
//
//  Created by Radim Langer on 17/06/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//


import UIKit

class CropImage {
    
    var imageStack = [CGImage]()
    var cropInitializedImage = UIImage()
    
    var croppingImageName: String?
    var cropImageToPiecesRows: Int?
    var cropImageToPiecesColumns: Int?
    
    
    init(croppingImageName: String?, cropImageToPiecesRows: Int?, cropImageToPiecesColumns: Int?) {
        
        self.croppingImageName = croppingImageName
        
        self.cropImageToPiecesRows = cropImageToPiecesRows
        self.cropImageToPiecesColumns = cropImageToPiecesColumns
        // crops and puts image parts into imageStack, If the variables for cropping image to parts are not null
        if (croppingImageName != nil && cropImageToPiecesRows != nil && cropImageToPiecesColumns != nil) {
            initializeImage(croppingImageName)
            cropImageToPartsPutToArray(cropImageToPiecesRows!, cropImageToPiecesColumn: cropImageToPiecesColumns!)
        }
    }
    
    
    func initializeImage(nameOfImage: String?) {
        if (nameOfImage != nil) {
            cropInitializedImage = UIImage(named: nameOfImage!)!
        }
    }
    
    
    func cropImageToPartsPutToArray(cropImageToPiecesRow: Int, cropImageToPiecesColumn: Int) {
        
        let scale = cropInitializedImage.scale
        
        let imageSize = CGSizeMake(cropInitializedImage.size.width/scale, cropInitializedImage.size.height/scale)
        
        for rowIndex in 0...cropImageToPiecesRow - 1 {
            for columnIndex in 0...cropImageToPiecesColumn - 1 {
                let imageSizeRect = CGRectMake(CGFloat(columnIndex) * imageSize.width, CGFloat(rowIndex) * imageSize.height, imageSize.width, imageSize.height)
                
                let onePieceImage = CGImageCreateWithImageInRect(cropInitializedImage.CGImage, imageSizeRect)
                imageStack.append(onePieceImage!)
                
            }
        }
    }
    
    
    
}