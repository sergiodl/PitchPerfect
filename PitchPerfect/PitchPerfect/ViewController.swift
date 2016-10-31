//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Damo de Lemos, Sergio on 10/30/16.
//  Copyright © 2016 Damo de Lemos, Sergio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func racordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in progress"
    }

    @IBAction func stopRecording(_ sender: Any) {
        print("stop recording")
    }

}

