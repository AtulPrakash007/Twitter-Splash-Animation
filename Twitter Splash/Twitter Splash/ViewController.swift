//
//  ViewController.swift
//  Twitter Splash
//
//  Created by Mac on 1/9/18.
//  Copyright © 2018 AtulPrakash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTwitterSplashAnimation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //---------------------------------
    //--- In case of API Call
    //--- Either call the method definition inside the Api Call,
    //--- and after completion process the heartattack variable as false
    //--- OR
    //--- Define the splash view global for this view controller and add subview in API call
    //--- and after completion process the heartattack variable as false
    //---------------------------------
    func loadTwitterSplashAnimation() -> Void {
        let splashView = SplashView(iconImage: UIImage(named: "toast")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red: 70/255, green: 154/255, blue: 233/255, alpha: 1))
        
        self.view.addSubview(splashView)
        
        splashView.duration = 5.0
        splashView.animationType = AnimationType.heartBeat
        splashView.iconColor = UIColor.red
        splashView.useCustomIconColor = false
        
        splashView.startAnimation(){
            print("Completed")
        }
        
        // This will deliver the message to stop the heartbeat
        // Need to call like same after the completion of API, means when screen transition needs.
        // Comment and run this, you will see heartbeat will never stops.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            print("Heart Attack Stopped")
            splashView.finishHeartBeatAnimation()
        })
    }
}

