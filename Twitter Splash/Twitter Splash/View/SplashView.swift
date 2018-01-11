//
//  SplashView.swift
//  Twitter Splash
//
//  Created by Mac on 1/9/18.
//  Copyright © 2018 AtulPrakash. All rights reserved.
//

import Foundation
import UIKit

class SplashView: UIView {

    
    //---------------------------------
    //--- pass the icon image, to view and to animate -- both are same image
    //---------------------------------
    open var iconImage: UIImage? {
        
        didSet{
            if let iconImage = self.iconImage{
                imageView?.image = iconImage
            }
        }
        
    }
    
    //---------------------------------
    //--- pass the icon color, if required. By default its white, like twitter
    //---------------------------------
    open var iconColor: UIColor = UIColor.white{
        
        didSet{
            
            imageView?.tintColor = iconColor
        }
        
    }
    
    //---------------------------------
    //--- Custom icon color if required to pass with rendering
    //--- True - if using background color
    //--- false - if using background image
    //---------------------------------
    open var useCustomIconColor: Bool = false{
        
        didSet{
            
            if(useCustomIconColor == true){
                
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                }
            }
            else{
                
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                }
            }
        }
    }
    
    //---------------------------------
    //--- pass the icon size,
    //--- In case using launch screen with the Imageview, the size should match the icon size of the imageview.
    //--- If don't want to see the heartbeat till API call, then Image view should be visible there in splash screen too.
    //---------------------------------
    
    open var iconInitialSize: CGSize = CGSize(width: 60, height: 60) {
        
        didSet{
            
            imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        }
    }
    
    
    //---------------------------------
    //--- If required to show image in spite of background color
    //---------------------------------
    open var backgroundImageView: UIImageView?
    
    //---------------------------------
    //--- Image view used to hold the icon
    //---------------------------------
    open var imageView: UIImageView?
    
    //---------------------------------
    //--- Default Twitter, as per requirement change to heartbeat
    //---------------------------------
    open var animationType: AnimationType = AnimationType.twitter
    
    //---------------------------------
    //--- Duration of animation, default is 1.5, In case of Heartbeat-pass 3
    //---------------------------------
    open var duration: Double = 1.5
    
    //---------------------------------
    //--- delay of the animation to zoom in and out
    //---------------------------------
    open var delay: Double = 0.5
    
    //---------------------------------
    //--- Default - False - will continuos beat, True - stop the heartbeat
    //---------------------------------
    open var heartAttack: Bool = false
    
    //---------------------------------
    //--- Repeat counter of heartbeat, Default - 1
    //---------------------------------
    open var minimumBeats: Int = 1
    
    //---------------------------------
    //--- Default constructor of the class
    //--- iconImage:       The Icon image to show the animation
    //--- iconInitialSize: The initial size of the icon image
    //--- backgroundColor: The background color of the image
    //--- returns: SplashView Object
    //---------------------------------
    public init(iconImage: UIImage, iconInitialSize:CGSize, backgroundColor: UIColor)
    {
        //Sets the initial values of the image view and icon view
        self.imageView = UIImageView()
        self.iconImage = iconImage
        self.iconInitialSize = iconInitialSize
        //Inits the view to the size of the screen
        super.init(frame: (UIScreen.main.bounds))
        
        imageView?.image = iconImage
        imageView?.tintColor = iconColor
        //Set the initial size and position
        imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        //Sets the content mode and set it to be centered
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        imageView?.center = self.center
        
        //Adds the icon to the view
        self.addSubview(imageView!)
        
        //Sets the background color
        self.backgroundColor = backgroundColor
        
    }
    
    //---------------------------------
    //--- Default constructor of the class
    //--- iconImage:       The Icon image to show the animation
    //--- iconInitialSize: The initial size of the icon image
    //--- backgroundImage: The background image to show behined icon
    //--- returns: SplashView Object
    //---------------------------------
    public init(iconImage: UIImage, iconInitialSize:CGSize, backgroundImage: UIImage)
    {
        //Sets the initial values of the image view and icon view
        self.imageView = UIImageView()
        self.iconImage = iconImage
        self.iconInitialSize = iconInitialSize
        //Inits the view to the size of the screen
        super.init(frame: (UIScreen.main.bounds))
        
        imageView?.image = iconImage
        imageView?.tintColor = iconColor
        //Set the initial size and position
        imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        //Sets the content mode and set it to be centered
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        imageView?.center = self.center
        
        //Sets the background image
        self.backgroundImageView = UIImageView()
        backgroundImageView?.image = backgroundImage
        backgroundImageView?.frame = UIScreen.main.bounds
        backgroundImageView?.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(backgroundImageView!)
        
        //Adds the icon to the view
        self.addSubview(imageView!)
        
    }
    
    //---------------------------------
    //--- Decoder and coder haven't defined.
    //---------------------------------
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) haven't implemented")
    }
}
