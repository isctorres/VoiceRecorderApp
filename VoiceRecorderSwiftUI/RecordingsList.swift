//
//  RecordingsList.swift
//  VoiceRecorderSwiftUI
//
//  Created by Isc. Torres on 3/6/20.
//  Copyright © 2020 isctorres. All rights reserved.
//

import SwiftUI

struct RecordingsList: View {
    @ObservedObject var audioRecorder: AudioRecorder
    var body: some View {
        List{
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            .onDelete(perform: delete) // Asignamos a cada item la opcion de seleccionarlo para borrar
        }
    }
    
    func delete(at offsets: IndexSet){
        var urlsToDelete = [URL]()
        for index in offsets{
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingRow: View{
    
    var audioURL : URL
    @ObservedObject var audioPlayer = AudioPlayer()     // Objeto propagado
    
    var body: some View{
        HStack{
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            if audioPlayer.isPlaying == false{
                Button(action:{
                    //print("Start playing audio")
                    self.audioPlayer.startPlayBack(audio: self.audioURL)
                }){
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            }else{
                Button(action: {
                    //print("Stop playing audio")
                    self.audioPlayer.stopPlayback()
                }){
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder())
    }
}
