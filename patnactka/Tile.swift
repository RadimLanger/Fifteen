////
////  Tile.swift
////  patnactka
////
////  Created by Radim Langer on 09/05/16.
////  Copyright © 2016 Radim Langer. All rights reserved.
////
//
//import UIKit
//
//class Tile {
//    
//    let cropImage = CropImageToParts()
////    Defining model
//    var matrix = [[(Int,UIButton,image: CGImage)]]()
//
//    var blankTileX = 0
//    var blankTileY = 0
//    var tileToMoveX = 0
//    var tileToMoveY = 0
//    
//    var matrixHelpInt = 0
//    
////    Initializing matrix
//    init() {
//        for outside in 0...3 {
//            matrix.append([])
//            for inside in 0...3 {
//                self.matrix[outside].append((matrixHelpInt, (UIButton(type: UIButtonType.Custom)), cropImage.imageStack[matrixHelpInt]))
//                
//                if outside == 0 && inside == 0 {
//                    matrix[outside][inside].1.backgroundColor = UIColor.whiteColor()
//                } else {
//                    matrix[outside][inside].1.backgroundColor = UIColor.greenColor()
//                    matrix[outside][inside].1.setImage(UIImage(CGImage: cropImage.imageStack[matrixHelpInt]), forState: UIControlState.Normal)
//                }
//                matrix[outside][inside].1.setTitle("\(matrixHelpInt)", forState: UIControlState.Normal)
//                self.matrixHelpInt = self.matrixHelpInt + 1
//            }
//        }
//        
//        matrixHelpInt = 0
//    }
//    
////    Searches for clicked and blank tile and sets the variables
//    func searchForClickedAndBlankNumber(numberOfClickedButton: Int) {
//        for outside in 0...3 {
//            for inside in 0...3 {
//                if matrix[outside][inside].0 == 0 {
//                    blankTileY = outside
//                    blankTileX = inside
//                }
//                if matrix[outside][inside].0 == numberOfClickedButton {
//                    tileToMoveY = outside
//                    tileToMoveX = inside
//                }
//            }
//        }
//    }
//    
////    Checks if we can move, if yes - returns true
//    func checkcanMove(tileToMoveY: Int, tileToMoveX: Int, blankTileY: Int, blankTileX: Int) -> Bool {
//        if tileToMoveX == blankTileX && tileToMoveY == blankTileY {
//            return false
//        }
//        
//        if tileToMoveX == blankTileX {
//            if (abs(tileToMoveY - blankTileY) <= 1){
//                return true
//            }
//            
//        } else if tileToMoveY == blankTileY {
//            if (abs(tileToMoveX - blankTileX) <= 1) {
//                return true
//            }
//            
//        }
//        return false
//    }
//    
////    Checks and returns number of correctly placed tiles
//    func checkCompleteMatrice() -> Int {
//        var counterOfCorrectTiles: Int = 0
//        matrixHelpInt = 0
//        
//        for outside in 0...3 {
//            for inside in 0...3 {
//                if matrix[outside][inside].0 == matrixHelpInt {
//                    counterOfCorrectTiles += 1
//                }
//                matrixHelpInt += 1
//            }
//        }
//        matrixHelpInt = 0
//        return counterOfCorrectTiles
//    }
//    
//    func randomizeMatrice() {
//        let random = Int(arc4random_uniform(4))
//        var random2 = Int(arc4random_uniform(4))
//        let random3 = Int(arc4random_uniform(4))
//        var random4  = Int(arc4random_uniform(4))
//        
//        while (random == random2 && random3 == random4) || (random == random3 && random2 == random4) {
//            random2 = Int(arc4random_uniform(4))
//            random4 = Int(arc4random_uniform(4))
//        }
//        
//        moveTiles(random, tileToMoveX: random2, blankTileY: random3, blankTileX: random4)
//    }
//    
//    
//    func moveTiles(tileToMoveY: Int, tileToMoveX: Int, blankTileY: Int, blankTileX: Int) {
//        swap(&matrix[blankTileY][blankTileX].0, &matrix[tileToMoveY][tileToMoveX].0)
//        swap(&matrix[blankTileY][blankTileX].image, &matrix[tileToMoveY][tileToMoveX].image)
//    }
//    
//}
//
//
