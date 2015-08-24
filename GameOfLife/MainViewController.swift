//
//  MainViewController.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 20/06/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var timer: NSTimer?
    var gridController: GridViewController?
    @IBOutlet weak var playButtonInstance: PlayButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.playButtonInstance.currentPlayState = playState()
    }

    @IBAction func playButtonTapped(sender: PlayButton) {
        sender.currentPlayState.action()
    }
    
    @IBAction func clear(sender: AnyObject) {
        self.timer?.invalidate()
        self.gridController?.clear()
        self.playButtonInstance.currentPlayState = playState()
    }
    
    func play() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self.gridController!, selector: Selector("nextStep"), userInfo: nil, repeats: true)
        self.playButtonInstance.currentPlayState = pauseState()
    }
    
    func pause() {
        self.timer?.invalidate()
        self.playButtonInstance.currentPlayState = playState()
    }
    
    func playState() -> PlayButtonState {
        return PlayButtonState(action: self.play, title: "Play")
    }
    
    func pauseState() -> PlayButtonState {
        return PlayButtonState(action: self.pause, title: "Pause")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "showGridSegue" {
            self.gridController = segue.destinationViewController as? GridViewController
        }
        // Pass the selected object to the new view controller.
    }

}
