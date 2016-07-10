//
//  TileView.swift
//  patnactka
//
//  Created by Radim Langer on 04/07/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    let enablePicturesSwitch = UISwitch()
    let randomizeButton = UIButton(type: UIButtonType.System)
    //    Matrix touple model
    var matrix = [[(Int,UIButton,image: CGImage)]]()
    let sizeMatrix = 4 // square matrix 4 * 4
    let croppingImageName = "nickCrop.png"
    
    var blankTileCoordinates = (x: 0, y: 0)
    var clickedTileCoordinates = (x: 0, y: 0)
    
    var quaterViewWidth: CGFloat {
        get {
            return round(CGFloat(bounds.width/4))
        }
    }
    var viewHeight: CGFloat {
        get {
            return CGFloat(frame.size.height)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGrayColor()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let croppedImagesToParts = CropImage(croppingImageName: croppingImageName, cropImageToPiecesRows: sizeMatrix, cropImageToPiecesColumns: sizeMatrix)
        
        initializeTilesAsButtonsAndSetButtonsImage(croppedImagesToParts.imageStack)
        initializeSwitchForEnablingPhotos()
        createRandomizeButton()
        
    }
    
    
    func initializeTilesAsButtonsAndSetButtonsImage(croppedImagesForTiles: [CGImage]) {
        //        counter helper Int for setting buttons Title
        var counter = 0
        for rowIndex in 0...sizeMatrix - 1 {
            self.matrix.append([])
            for columnIndex in 0...sizeMatrix - 1 {
                self.matrix[rowIndex].append((counter, (UIButton(type: UIButtonType.Custom)), croppedImagesForTiles[counter]))
                
                let x = positionTileHelper(columnIndex)
                let y = positionTileHelper(rowIndex)
                
                //                First tile gets white color -> This will be blank tile
                if counter == 0 {
                    matrix[rowIndex][columnIndex].1.backgroundColor = UIColor.whiteColor()
                } else {
                    matrix[rowIndex][columnIndex].1.backgroundColor = UIColor.greenColor()
                    matrix[rowIndex][columnIndex].1.setImage(UIImage(CGImage: croppedImagesForTiles[counter]), forState: .Normal)
                }
                
                matrix[rowIndex][columnIndex].1.setTitle(String(counter), forState: UIControlState.Normal)
                matrix[rowIndex][columnIndex].1.addTarget(self, action:#selector(self.buttonClicked), forControlEvents: .TouchUpInside)
                matrix[rowIndex][columnIndex].1.frame = CGRectMake(x, y, quaterViewWidth, quaterViewWidth)
                
                counter = counter + 1
                self.addSubview(matrix[rowIndex][columnIndex].1)
            }
        }
        
    }
    
    //    Returns x,y coordinates for tiles
    func positionTileHelper(position: Int) -> CGFloat {
        
        if position == 0 {
            return 0
        } else if position == 1 {
            return quaterViewWidth
        } else if position == 2 {
            return 2 * quaterViewWidth
        } else {
            return 3 * quaterViewWidth
        }
    }
    
    func createRandomizeButton() {
        let matrixSize = CGFloat(sizeMatrix)
        let randomizeStringButton = NSLocalizedString("RANDOMIZE", comment: "Randomize button")
        
        randomizeButton.setTitle(randomizeStringButton, forState: .Normal)
        randomizeButton.addTarget(self, action:#selector(self.randomizeTiles), forControlEvents: .TouchUpInside)
        //        labelSize for knowing how big is going to be the button
        let labelSize = randomizeButton.sizeThatFits(CGSizeMake(self.frame.size.width, CGFloat.max)) ?? CGSizeZero
        randomizeButton.frame = CGRectMake(20, (quaterViewWidth * matrixSize) + 5, labelSize.width, labelSize.height)
        
        self.addSubview(randomizeButton)
    }
    
    
    func initializeSwitchForEnablingPhotos() {
        let matrixSize = CGFloat(sizeMatrix)
        let downPadding = CGFloat(10)
        let rightPadding = CGFloat(15)
        
        enablePicturesSwitch.frame = CGRectMake((quaterViewWidth * 3) - rightPadding, (quaterViewWidth * matrixSize) + downPadding, 0, 0)
        enablePicturesSwitch.on = true
        enablePicturesSwitch.setOn(true, animated: false);
        enablePicturesSwitch.addTarget(self, action: #selector(self.refreshTiles), forControlEvents: .ValueChanged)
        self.addSubview(enablePicturesSwitch)
    }
    
    
    
    func buttonClicked(index: UIButton) {
        let indexOfClickedButton = Int(index.currentTitle!)
        
        //        Setting blankTileX/Y; tileToMoveX/Y in Tile class
        searchForClickedAndBlankNumberSetCoordinates(indexOfClickedButton!)
        if (checkTilesCanSwap(clickedTileCoordinates, blankTileCoordinates: blankTileCoordinates)) {
            switchBlankClickedTiles(clickedTileCoordinates, blankTileCoordinates: blankTileCoordinates)
            
            refreshTiles()
        }
    }
    
    func refreshTiles() {
        
        for rowIndex in 0...sizeMatrix - 1 {
            for columnIndex in 0...sizeMatrix - 1 {
                
                let button = matrix[rowIndex][columnIndex].1
                let buttonTitle = matrix[rowIndex][columnIndex].0
                let buttonImage = matrix[rowIndex][columnIndex].image
                
                if (enablePicturesSwitch.on){
                    button.setImage(UIImage(CGImage: buttonImage), forState: .Normal)
                } else {
                    button.setImage(UIImage(), forState: .Normal)
                }
                
                button.setTitle(String(buttonTitle), forState: .Normal)
                
                if Int(button.currentTitle!) == 0 {
                    button.backgroundColor = UIColor.whiteColor()
                    button.setImage(UIImage(), forState: .Normal)
                } else {
                    button.backgroundColor = UIColor.greenColor()
                }
                
            }
        }
        setNeedsDisplay()
        //        Calls method in ViewController when we click on a tile
        NSNotificationCenter.defaultCenter().postNotificationName("NumbersOfCorrectlyPlacedTilesChanged", object: self)
        
    }
    
    
    
    //    Sets coordinates for blankTile,clickedTile variables in matrix
    func searchForClickedAndBlankNumberSetCoordinates(numberOfClickedButton: Int) {
        for rowIndex in 0...sizeMatrix - 1 {
            for columnIndex in 0...sizeMatrix - 1 {
                if Int(matrix[rowIndex][columnIndex].1.currentTitle!) == 0 {
                    blankTileCoordinates.x = columnIndex
                    blankTileCoordinates.y = rowIndex
                }
                if Int(matrix[rowIndex][columnIndex].1.currentTitle!) == numberOfClickedButton {
                    clickedTileCoordinates.x = columnIndex
                    clickedTileCoordinates.y = rowIndex
                }
            }
        }
    }
    
    //        Checks if we can swap blank tile with the one that was clicked on, if yes - returns true
    func checkTilesCanSwap(clickedTileCoordinates: (x: Int, y: Int), blankTileCoordinates: (x: Int,y: Int)) -> Bool {
        //        If the coordinates are the same, we can't swap the tiles
        if clickedTileCoordinates.x == blankTileCoordinates.x && clickedTileCoordinates.y == blankTileCoordinates.y {
            return false
        }
        //        If the tiles are on same line and the distance between them is <= 1, we can swap them
        if clickedTileCoordinates.x == blankTileCoordinates.x {
            if (abs(clickedTileCoordinates.y - blankTileCoordinates.y) <= 1){
                return true
            }
            
        } else if clickedTileCoordinates.y == blankTileCoordinates.y {
            if (abs(clickedTileCoordinates.x - blankTileCoordinates.x) <= 1) {
                return true
            }
        }
        return false
    }
    
    func switchBlankClickedTiles(clickedTileCoordinates:(x: Int, y: Int), blankTileCoordinates:(x: Int,y:Int))
    {
        swap(&matrix[blankTileCoordinates.y][blankTileCoordinates.x].0,
             &matrix[clickedTileCoordinates.y][clickedTileCoordinates.x].0)
        swap(&matrix[blankTileCoordinates.y][blankTileCoordinates.x].image,
             &matrix[clickedTileCoordinates.y][clickedTileCoordinates.x].image)
    }
    
    //    Randomize 11 tiles
    func randomizeTiles() {
        for _ in 0...10 {
            randomizeMatrix()
        }
    }
    
    
    func randomizeMatrix() {
        //         4 random Int numbers are generated
        let random = Int(arc4random_uniform(4))
        var random2 = Int(arc4random_uniform(4))
        let random3 = Int(arc4random_uniform(4))
        var random4  = Int(arc4random_uniform(4))
        //    change the random2,random4 to be differend (for x,y coordinates) or (for clickedTile and blankTile)
        //      the x != y or clickedTile.x/y != blankTile.x/y
        while (random == random2 && random3 == random4) || (random == random3 && random2 == random4) {
            random2 = Int(arc4random_uniform(4))
            random4 = Int(arc4random_uniform(4))
        }
        
        switchBlankClickedTiles((random, random2), blankTileCoordinates: (random3, random4))
        refreshTiles()
    }
    
    
    //    Checks and returns number of correctly placed tiles
    func numberOfCorrectlyPlacedTiles() -> Int {
        var counterOfCorrectTiles: Int = 0
        var counter = 0
        
        for rowIndex in 0...sizeMatrix - 1 {
            for columnIndex in 0...sizeMatrix - 1 {
                if matrix[rowIndex][columnIndex].0 == counter {
                    counterOfCorrectTiles += 1
                }
                counter += 1
            }
        }
        counter = 0
        return counterOfCorrectTiles
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
