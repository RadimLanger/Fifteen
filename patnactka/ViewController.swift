//
//  ViewController.swift
//  patnactka
//
//  Created by Radim Langer on 09/05/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    Inherited classes
    let cropImage = CropImageToParts()
    let tiles = Tile()
    let circleProgressView = ProgressCircleView()
    
//    Switch and button
    let enablePicturesSwitch = UISwitch()
    let randomizeButton = UIButton(type: UIButtonType.System)
    
//    quaterViewWidth and viewHeight numbers for simplifying syntax
    var quaterViewWidth: CGFloat {
        get {
            return round(CGFloat(self.view.frame.size.width/4))
        }
    }
    var viewHeight: CGFloat {
        get {
            return CGFloat(self.view.frame.size.height)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGrayColor()
    
        cropImage.initializeImage()
        cropImage.cropImagePutToArray()
        
        drawCircle()
        initialize()
        
      
//        randomize()
        checkCompletition()
    }
    
    
    
    func initialize() {
//      addTarget to every created tile, get tile frame coordinates by computing, add tiles
        for outside in 0...3 {
            for inside in 0...3 {
                tiles.matrix[outside][inside].1.addTarget(self, action:#selector(self.buttonClicked), forControlEvents: .TouchUpInside)
                tiles.matrix[outside][inside].1.frame = CGRectMake(positionHelper(inside) - quaterViewWidth, positionHelper(outside), quaterViewWidth, quaterViewWidth)
                
                self.view.addSubview(tiles.matrix[outside][inside].1)
            }
        }
        // Add randomize button and switch for Photo/Numbers
        createRandomizeButton()
        createPictureSwitch()
    }
    
    func checkCompletition() {
//      How many tiles we have at the right place
        let partsOfCircleCorrect = tiles.checkCompleteMatrice()
        circleProgressView.counter = partsOfCircleCorrect
//      Sets the color to counterColor/outlineColor according how many tiles are at the right place
        setCircleColor(partsOfCircleCorrect)
    }
    
    func setCircleColor(partsOfCircleCorrect: Int) {
        
        if partsOfCircleCorrect == circleProgressView.puzzleCount {
            circleProgressView.counterColor = UIColor.greenColor()
            circleProgressView.outlineColor = UIColor.blueColor()
        }
        else if partsOfCircleCorrect > circleProgressView.puzzleCount / 2 {
            circleProgressView.counterColor = UIColor.orangeColor()
            circleProgressView.outlineColor = UIColor.purpleColor()
        }
        else {
            circleProgressView.counterColor = UIColor.redColor()
            circleProgressView.outlineColor = UIColor.yellowColor()
        }
    }
    
    func drawCircle() {
        circleProgressView.frame = CGRectMake(quaterViewWidth, viewHeight * 0.72, 200, 200)
//        Setting the UIView background color to White = 1, but alpha = 0 -> only the circle will be visible
        circleProgressView.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(circleProgressView)
    }
    
    func createRandomizeButton() {
        randomizeButton.addTarget(self, action:#selector(self.randomize), forControlEvents: .TouchUpInside)
        randomizeButton.frame = CGRectMake(20, viewHeight * 0.7, 100, 50)
        randomizeButton.setTitle("Randomize", forState: .Normal)
        self.view.addSubview(randomizeButton)
    }
    
    func createPictureSwitch() {
        enablePicturesSwitch.frame = CGRectMake(quaterViewWidth * 3, viewHeight * 0.72, 0, 0)
        enablePicturesSwitch.on = true
        enablePicturesSwitch.setOn(true, animated: false);
        enablePicturesSwitch.addTarget(self, action: #selector(ViewController.refreshTilesView), forControlEvents: .ValueChanged);
        self.view.addSubview(enablePicturesSwitch);
    }

//    For randomizing tiles
    func randomize() {
        for _ in 1...10 {
            tiles.randomizeMatrice()
        }
        refreshTilesView()
        checkCompletition()
    }
    
    func positionHelper(position: Int) -> CGFloat {
        
        if position == 0 {
            return quaterViewWidth
        } else if position == 1 {
            return 2 * quaterViewWidth
        } else if position == 2 {
            return 3 * quaterViewWidth
        } else {
            return 4 * quaterViewWidth
        }
    }

//    For refreshing tiles
    func refreshTilesView() {
        for outside in 0...3 {
            for inside in 0...3 {
                let button = tiles.matrix[outside][inside].1
                let buttonTitle = tiles.matrix[outside][inside].0
                let buttonImage = tiles.matrix[outside][inside].image
                
//                Switching between Images / Numbers
                if (enablePicturesSwitch.on ){
                    button.setImage(UIImage(CGImage: buttonImage), forState: .Normal)
                } else {
                    button.setImage(UIImage(), forState: .Normal)
                }
                
                button.setTitle(String(buttonTitle), forState: .Normal)
                
//                Telling the 0. - blank tile has to stay white
                if Int(button.currentTitle!) == 0 {
                    button.backgroundColor = UIColor.whiteColor()
                    button.setImage(UIImage(), forState: .Normal)
                } else {
                    button.backgroundColor = UIColor.greenColor()
                }
            }
        }
        self.view.setNeedsDisplay()
    }


    func buttonClicked(index: UIButton) {
        let numberOfClickedButton = Int(index.currentTitle!)
//        Setting blankTileX/Y; tileToMoveX/Y in Tile class
        tiles.searchForClickedAndBlankNumber(numberOfClickedButton!)
//        Can Move?
        if (tiles.checkcanMove(tiles.tileToMoveY, tileToMoveX: tiles.tileToMoveX, blankTileY: tiles.blankTileY, blankTileX: tiles.blankTileX)) {
//            Switch tile images and titles
            tiles.moveTiles(tiles.tileToMoveY, tileToMoveX: tiles.tileToMoveX, blankTileY: tiles.blankTileY, blankTileX: tiles.blankTileX)
        }
        checkCompletition()
        refreshTilesView()
    }

}

