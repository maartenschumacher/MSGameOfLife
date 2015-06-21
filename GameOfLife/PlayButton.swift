//
//  playButton.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 21/06/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import UIKit

struct ButtonState {
    let title: String
    let action: Selector
}

class PlayButton: UIButton {
    
    let playState = ButtonState(title: "play", action: Selector("play"))
    let pauseState = ButtonState(title: "pause", action: Selector("pause"))
    
    var currentPlayState: ButtonState?
    
    func setButtonState(state: ButtonState) {
        self.setTitle(state.title, forState: UIControlState.Normal)
        self.currentPlayState = state
    }
    
}
