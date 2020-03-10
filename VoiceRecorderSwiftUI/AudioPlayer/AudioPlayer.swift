//
//  AudioPlayer.swift
//  VoiceRecorderSwiftUI
//
//  Created by Isc. Torres on 3/7/20.
//  Copyright © 2020 isctorres. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    var audioPlayer: AVAudioPlayer!
    
    var isPlaying = false{
        didSet{
            objectWillChange.send(self)
        }
    }
    
    func startPlayBack(audio: URL){
        let playbackSession = AVAudioSession.sharedInstance()
        do{
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        }catch{ print("Playing over the device`s speaker failed") }
            
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self  // Protocolo esta en la misma clase
            audioPlayer.play()
            isPlaying = true
        }catch{ print("Playback failed.")}
    }
    
    func stopPlayback(){
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}

/*struct AudioPlayer_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayer()
    }
}*/
