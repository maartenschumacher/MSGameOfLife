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

        self.playButtonInstance.currentPlayState = self.playButtonInstance.playState
    }

    @IBAction func playButtonTapped(sender: PlayButton) {
        sender.sendAction(sender.currentPlayState!.action, to: self, forEvent: nil)
    }
    
    @IBAction func clear(sender: AnyObject) {
        self.timer?.invalidate()
        self.gridController?.clear()
        self.playButtonInstance.setButtonState(self.playButtonInstance.playState)
    }
    
    func play() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self.gridController!, selector: Selector("nextStep"), userInfo: nil, repeats: true)
        self.playButtonInstance.setButtonState(self.playButtonInstance.pauseState)
    }
    
    func pause() {
        self.timer?.invalidate()
        self.playButtonInstance.setButtonState(self.playButtonInstance.playState)
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
