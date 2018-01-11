//
//  SplashAnimation.swift
//  Twitter Splash
//
//  Created by Mac on 1/9/18.
//  Copyright © 2018 AtulPrakash. All rights reserved.
//

import Foundation
import UIKit

public typealias AnimationCompletion = () -> Void
public typealias AnimationExecution = () -> Void

// MARK: - SplashView Class extension to start the animation
extension SplashView {
    
    //---------------------------------
    //--- The function called to start the animation, Entry point of extention.
    //---------------------------------
    public func startAnimation(_ completion: AnimationCompletion? = nil)
    {
        switch animationType{
        case .twitter:
            playTwitterAnimation(completion)
            
        case .heartBeat:
            playHeartBeatAnimation(completion)
        }
    }
    
    
    //---------------------------------
    //--- Makes the twitter animation overlay.
    //---------------------------------
    public func playTwitterAnimation(_ completion: AnimationCompletion? = nil)
    {
        
        if let imageView = self.imageView {
            
            //Define the shink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.3
            
            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(), animations: {
                //Shrinks the image
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.75,y: 0.75)
                imageView.transform = scaleTransform
                
                //When animation completes, grow the image
            }, completion: { finished in
                
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    //---------------------------------
    //--- Twitter Zoom out animation performs here.
    //--- Remove the view after animation
    //---------------------------------
    public func playZoomOutAnimation(_ completion: AnimationCompletion? = nil)
    {
        if let imageView =  imageView
        {
            let growDuration: TimeInterval =  duration * 0.3
            
            UIView.animate(withDuration: growDuration, animations:{
                
                imageView.transform = self.getZoomOutTranform()
                self.alpha = 0
                
                //When animation completes remote self from super view
            }, completion: { finished in
                
                self.removeFromSuperview()
                
                completion?()
            })
        }
    }
    
    //---------------------------------
    //--- Makes the heartbeat animation for icon.
    //---------------------------------
    public func playHeartBeatAnimation(_ completion: AnimationCompletion? = nil)
    {
        if let imageView = self.imageView {
            
            let popForce = 1.5 // How much high can go.
            
            animateLayer({
                let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                animation.values = [0, 0.1 * popForce, 0.015 * popForce, 0.2 * popForce, 0]
                animation.keyTimes = [0, 0.25, 0.50, 0.75, 1]
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.duration = CFTimeInterval(self.duration/2)
                animation.isAdditive = true
                animation.repeatCount = Float(minimumBeats > 0 ? minimumBeats : 1)
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/2)
                imageView.layer.add(animation, forKey: "pop")
            }, completion: { [weak self] in
                if self?.heartAttack ?? true {
                    self?.playZoomOutAnimation(completion)
                } else {
                    self?.playHeartBeatAnimation(completion)
                }
            })
        }
    }
    
    
    //---------------------------------
    //--- stop the heart beat
    //--- Once the heart beat stops the Zoom out function called to perform the final animation
    //---------------------------------
    public func finishHeartBeatAnimation()
    {
        self.heartAttack = true
    }
    
    //---------------------------------
    //--- returns the default zoom out transform
    //---------------------------------
    fileprivate func getZoomOutTranform() -> CGAffineTransform
    {
        let zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 20, y: 20)
        return zoomOutTranform
    }
    
    //---------------------------------
    //--- Animate layer continuosly to show as heart beat
    //---------------------------------
    fileprivate func animateLayer(_ animation: AnimationExecution, completion: AnimationCompletion? = nil) {
        
        CATransaction.begin()
        if let completion = completion {
            CATransaction.setCompletionBlock { completion() }
        }
        animation()
        CATransaction.commit()
    }

}
