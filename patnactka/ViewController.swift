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
    var tilesView = TileView()
    var ProgressView: ProgressCircleView?
    
    //    Setting UI object sizes
    let circleProgressViewSize = CGFloat(200)
    let topTilesPadding = CGFloat(16)
    var tilesViewHeight: CGFloat?
    var tilesViewWidth: CGFloat?
    
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
        drawTiles()
        ProgressView = ProgressCircleView(frame: CGRect.zero, puzzleCount: tilesView.sizeMatrix * tilesView.sizeMatrix)
        drawCircle()
        //         Updates progress circle view after clicking on a tile
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateProgressCircleView), name: "NumbersOfCorrectlyPlacedTilesChanged", object: nil)
    }
    
    func drawTiles() {
        tilesViewHeight = viewHeight
        tilesViewWidth = quaterViewWidth * 4
        
        tilesView.frame = CGRectMake(0, topTilesPadding, tilesViewWidth!, tilesViewHeight!)
        self.view.addSubview(tilesView)
    }
    
    func drawCircle() {
        let positionX = quaterViewWidth
        let positionY = viewHeight * 0.65
        
        ProgressView!.frame = CGRectMake(positionX, positionY, circleProgressViewSize, circleProgressViewSize)
        //        Setting the UIView background color to White = 1, but alpha = 0 -> only the circle will be visible
        ProgressView!.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(ProgressView!)
    }
    
    func updateProgressCircleView() {
        ProgressView!.counter = tilesView.numberOfCorrectlyPlacedTiles()
    }
    
    func setProgressCircleViewFullNumber() {
        ProgressView!.puzzleCount = tilesView.numberOfCorrectlyPlacedTiles() + 2
    }
}

