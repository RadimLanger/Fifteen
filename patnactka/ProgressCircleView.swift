//
//  ProgressCircleView.swift
//  patnactka
//
//  Created by Radim Langer on 27/06/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//

import UIKit

class ProgressCircleView: UIView {
    
    var puzzleCount: Int?
    let π: CGFloat = CGFloat(M_PI)
    
    init(frame: CGRect, puzzleCount: Int?) {
        super.init(frame: frame)
        self.puzzleCount = puzzleCount
//        Setting the counter to max at the beginning
        counter = puzzleCount!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var counter: Int = 0 {
        didSet {
            if counter <=  puzzleCount {
                //the view needs to be refreshed
                setCircleColor(counter)
                setNeedsDisplay()
            }
        }
    }
    var counterColor: UIColor = UIColor.greenColor()
    var outlineColor: UIColor = UIColor.blueColor()
    
    // For setting color of outer and inner arc according the counter integer
    func setCircleColor(partsOfCircleCorrect: Int) {
        
        if counter == puzzleCount {
            counterColor = UIColor.greenColor()
            outlineColor = UIColor.blueColor()
        }
        else if counter > puzzleCount! / 2 {
            counterColor = UIColor.orangeColor()
            outlineColor = UIColor.purpleColor()
        }
        else {
            counterColor = UIColor.redColor()
            outlineColor = UIColor.yellowColor()
        }
    }
    
    
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = (center.x + center.y) / 2.5
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Draw the outline
        
        //first calculating the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        
        //then calculating the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(puzzleCount!)
        
        //then multiplying out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //drawing the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //draw the inner arc
        outlinePath.addArcWithCenter(center,
                                     radius: bounds.width/2 - arcWidth + 2.5,
                                     startAngle: outlineEndAngle,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        //close the path
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
    }
}
