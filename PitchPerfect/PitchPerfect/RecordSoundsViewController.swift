//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Controller class for the recording screen.
//
//  Created by Damo de Lemos, Sergio on 10/30/16.
//  Copyright © 2016 Damo de Lemos, Sergio. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    //UI Elements
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordingButton: UIButton!

    var audioRecorder:AVAudioRecorder!
    
    //Executed when the start record button is pressed.
    @IBAction func racordAudio(_ sender: Any) {
        changeUiState(isRecording: true)
        doRecordAudio()
    }

    //Executed when the stop record button is pressed.
    @IBAction func stopRecording(_ sender: Any) {
        changeUiState(isRecording: false)
        doStopRecordingAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingButton.isEnabled = false
    }
    
    //Implementation of audio related functions
    func doRecordAudio() {
        print("Start recording")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoid.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        //Make sure the sound is played on the speakers
        try! session.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func doStopRecordingAudio() {
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Recording finished")
        
        if(flag) {
            //If everything is OK with saving the audio file, go to the playback screen.
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
    }
    
    func changeUiState(isRecording : Bool) {
        recordingLabel.text = isRecording ? "Recording in progress" : "Tap to record"
        stopRecordingButton.isEnabled = isRecording
        startRecordingButton.isEnabled = !isRecording
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            //Prepare the state of the playback screen
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}
