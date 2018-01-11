//
//  AnimationType.swift
//  Twitter Splash
//
//  Created by Mac on 1/9/18.
//  Copyright © 2018 AtulPrakash. All rights reserved.
//

import Foundation

//---------------------------------
//--- Twitter: The default animation type is the Twitter App animation
//--- If required to call the API, call the heartbeat animation
//---------------------------------
public enum AnimationType: String{
    case twitter
    case heartBeat
}
