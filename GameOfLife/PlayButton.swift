//
//  playButton.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 21/06/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import UIKit

struct PlayButtonState {
    let action: () -> ()
    let title: String
}

class PlayButton: UIButton {
    
    var currentPlayState: PlayButtonState!
    {
        didSet {
            self.setTitle(currentPlayState.title, forState: .Normal)
        }

    }
}