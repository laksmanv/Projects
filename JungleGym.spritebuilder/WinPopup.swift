//
//  WinPopup.swift
//  JungleGym
//
//  Created by Laksman Veeravagu on 7/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class WinPopup: CCNode {
    
    var nextLevelName = "Level1"
    
    func loadNextLevel() {
        let restartScene = CCBReader.loadAsScene(nextLevelName)
        let transition = CCTransition(fadeWithDuration: 0.8)
        CCDirector.sharedDirector().presentScene(restartScene, withTransition: transition)
    }
    
}