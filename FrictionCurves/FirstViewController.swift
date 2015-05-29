//
//  FirstViewController.swift
//  FrictionCurves
//
//  Created by Victor Baro on 3/5/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var topViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var middleViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var movingViewLeadingConstraint: NSLayoutConstraint!
    
    let horizontalLimit : CGFloat = 160.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addVerticalLine()
        
    }
    @IBAction func viewDragged(sender: UIPanGestureRecognizer) {
        let xPosition = sender.locationInView(view).x
        movingViewLeadingConstraint.constant = linearConstraintValueForXPosition(xPosition)
        
        if (hasExceededVerticalLine(xPosition)) {
            topViewLeadingConstraint.constant = sqrtConstraintValueForXPosition(xPosition)
            middleViewLeadingConstraint.constant = lognConstraintValueForXPosition(xPosition)
            bottomLeadingConstraint.constant = powConstraintValueForXPosition(xPosition)
            
            if(sender.state == UIGestureRecognizerState.Ended ){
                movingViewLeadingConstraint.constant = finalConstraintValue()
                topViewLeadingConstraint.constant = finalConstraintValue()
                middleViewLeadingConstraint.constant = finalConstraintValue()
                bottomLeadingConstraint.constant = finalConstraintValue()
            }
        } else {
            topViewLeadingConstraint.constant = linearConstraintValueForXPosition(xPosition)
            middleViewLeadingConstraint.constant = linearConstraintValueForXPosition(xPosition)
            bottomLeadingConstraint.constant = linearConstraintValueForXPosition(xPosition)
        }

    }


    func linearConstraintValueForXPosition(xPosition : CGFloat) -> CGFloat {
        return xPosition - CGRectGetWidth(movingView.frame)/2
    }
    func sqrtConstraintValueForXPosition(xPosition : CGFloat) -> CGFloat {
        let linearValue = linearConstraintValueForXPosition(xPosition)
        return finalConstraintValue() + sqrt(linearValue - finalConstraintValue())
    }
    func powConstraintValueForXPosition(xPosition : CGFloat) -> CGFloat {
        let linearValue = linearConstraintValueForXPosition(xPosition)
        let powValue = pow(linearValue/finalConstraintValue(), 4.0)
        return linearValue - powValue
    }
    func lognConstraintValueForXPosition(xPosition : CGFloat) -> CGFloat {
        let linearValue = linearConstraintValueForXPosition(xPosition)
        return finalConstraintValue() * (1 + log10(linearValue/finalConstraintValue()))
    }
    
    
//Helping methods
    func addVerticalLine() {
        let lineThickness : CGFloat = 2.0;
        let lineFrame = CGRectMake(horizontalLimit - lineThickness/2, 0, lineThickness, CGRectGetHeight(view.frame))
        var verticalLineView : UIView = UIView (frame: lineFrame)
        verticalLineView.backgroundColor = UIColor.redColor()
        view.addSubview(verticalLineView)
    }
    
    func finalConstraintValue() -> CGFloat {
        let viewWidth = CGRectGetWidth(movingView.frame)
        return horizontalLimit - viewWidth/2
    }
    func hasExceededVerticalLine(xPosition : CGFloat) -> Bool {
        return xPosition > horizontalLimit
    }
    
}

