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
//        Setting the UIView background color to White = 1, but alpha = 0 -> only the circle will be visible
        ProgressView!.backgroundColor = UIColor(white: 1, alpha: 0)

        ProgressView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ProgressView!)

        
        let widthConstraint = NSLayoutConstraint(item: ProgressView!, attribute: .Width, relatedBy: .Equal,
                                                 toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 200)
        
        let heightConstraint = NSLayoutConstraint(item: ProgressView!, attribute: .Height, relatedBy: .Equal,
                                                  toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 200)
        
        let xConstraint = NSLayoutConstraint(item: ProgressView!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: ProgressView!, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -30)
        
        NSLayoutConstraint.activateConstraints([widthConstraint, heightConstraint, xConstraint, yConstraint])
        
        
    }
    
    func updateProgressCircleView() {
        ProgressView!.counter = tilesView.numberOfCorrectlyPlacedTiles()
    }
    
    func setProgressCircleViewFullNumber() {
        ProgressView!.puzzleCount = tilesView.numberOfCorrectlyPlacedTiles() + 2
    }
}

