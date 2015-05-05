//
//  SecondViewController.swift
//  FrictionCurves
//
//  Created by Victor Baro on 3/5/15.
//  Copyright (c) 2015 Produkt. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {


    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    let verticalLimit : CGFloat = -200
    var totalTranslation : CGFloat = -200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func viewDragged(sender: UIPanGestureRecognizer) {
        let yTranslation = sender.translationInView(view).y
        
        if (hasExceededVerticalLimit(topViewConstraint.constant)){
            totalTranslation += yTranslation
            topViewConstraint.constant = logConstraintValueForYPoisition(totalTranslation)
            if(sender.state == UIGestureRecognizerState.Ended ){
                animateViewBackToLimit()
            }
        } else {
            topViewConstraint.constant += yTranslation
        }
        sender.setTranslation(CGPointZero, inView: view)
    }

    
    func hasExceededVerticalLimit(yPosition : CGFloat) -> Bool {
        return yPosition < verticalLimit
    }
    func logConstraintValueForYPoisition(yPosition : CGFloat) -> CGFloat {
        return verticalLimit * (1 + log10(yPosition/verticalLimit))
    }
    func animateViewBackToLimit() {
        self.topViewConstraint.constant = self.verticalLimit
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.totalTranslation = -200
            }, completion: nil)
    }
}

