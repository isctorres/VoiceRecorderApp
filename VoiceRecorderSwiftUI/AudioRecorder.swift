//
//  AudioRecorder.swift
//  VoiceRecorderSwiftUI
//
//  Created by Isc. Torres on 3/4/20.
//  Copyright © 2020 isctorres. All rights reserved.
//

import SwiftUI
import Combine
import AVFoundation
import Foundation

// Estructura que nos permite grabar y guardar los audios
class AudioRecorder: NSObject, ObservableObject {
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    // Iniciamos el AVAudioRecorder el cual nos ayudará a realizar la grabación
    var audioRecorder: AVAudioRecorder!
    
    // Arreglo para almacenar los audios grabados
    var recordings = [Recording]()
    
    var recording = false{
        didSet{
            objectWillChange.send(self)
        }
    }
    
    // Sobrecargamos el metodo init para que cuando cargue la pantalla obtenga el listado
    // de audios grabados y los muestre en la lista, el metodo es de NSObject
    override init(){
        super.init()
        fetchRecordings()
    }
    
    func startRecording(){
        let recordingSession = AVAudioSession.sharedInstance()
        do{
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        }catch{
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do{
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            recording = true
        }catch{
            print("Could not start recording")
        }
    }
    
    func stopRecording(){
        audioRecorder.stop()
        recording = false
        
        fetchRecordings()
    }
    
    func fetchRecordings(){
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
            
            recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
            objectWillChange.send(self)
        }
    }
    
    func deleteRecording(urlsToDelete: [URL]){
        for url in urlsToDelete{
            do{
                try FileManager.default.removeItem(at: url)
            }catch{print("File could not be deleted!")}
        }
        
        fetchRecordings()
    }
}
