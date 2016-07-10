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
    var circleProgressView = ProgressCircleView()
    var tilesView = TileView()
    
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
        let positionY = viewHeight * 0.72
        
        circleProgressView.frame = CGRectMake(positionX, positionY, circleProgressViewSize, circleProgressViewSize)
        //        Setting the UIView background color to White = 1, but alpha = 0 -> only the circle will be visible
        circleProgressView.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(circleProgressView)
    }
    
    func updateProgressCircleView() {
        circleProgressView.counter = tilesView.numberOfCorrectlyPlacedTiles()
    }
}

