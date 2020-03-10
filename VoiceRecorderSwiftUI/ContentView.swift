//
//  ContentView.swift
//  VoiceRecorderSwiftUI
//
//  Created by Isc. Torres on 3/4/20.
//  Copyright © 2020 isctorres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // Definimos el objeto de la clase AudioRecorder
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationView{
            VStack{
                if audioRecorder.recording == false{
                    
                    // Agregamos la lista con los audios grabados
                    RecordingsList(audioRecorder: audioRecorder)
                    
                    Button(action: {self.audioRecorder.startRecording()}){
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom,40)
                    }
                }else{
                    Button(action:{self.audioRecorder.stopRecording()}){
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitle("Voice Recorder")
            .navigationBarItems(trailing: EditButton()) // Habilitar seleccion individual de items
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
