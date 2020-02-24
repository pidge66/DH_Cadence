//
//  DetailsView.swift
//  DH_Cadence
//
//  Created by David Hou on 2/10/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit


struct DetailsView: View {
    
    @Binding var cadence: Cadence
    
    let player = Player()
    @State private var selectedToneIndex = 0
    @State private var selectedTone = ""
    let tones = ["250Hz.mp3", "440Hz.mp3", "1000Hz.mp3", "Gong1.mp3", "Gong2.mp3", "Gong3.mp3", "Gong4.mp3"]
    let tempos = [30, 60, 120, 240, 480]

    var body: some View {
        
        return VStack {
            HStack {
                Text("Name:").bold()
                TextField("Enter Cadence Name", text: $cadence.name)		
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }.padding(.top, 40)
                        
            HStack {
                Text("Repetitions:").bold()
                Stepper(value: $cadence.repetitions, in: 0...100, step: 1) {
                    Text("\(cadence.repetitions) times")
                }
            }

            Divider().padding(.top, 10).padding(.bottom, 20)
            
            HStack {
                Text("Metronomes:").bold()
                Spacer()
                Button(action: {
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 36))                })
            }

            List {
                //ForEach (Array(self.myCadences.cadences.enumerated()), id: \.element.id) { (i, cadence) in
                ForEach (cadence.metronomes.indices, id: \.self) { i in
                    // *** Can't pass cadence as binding!  so need index and thus requires id
                    // *** Also, the array itself must be Observable, not just its elements
                    VStack {
                        HStack {
                            Text("Tone:").bold()
                            TextField("Enter Tone Name", text: self.$cadence.metronomes[i].tone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Text(self.cadence.metronomes[i].tone)
                        }
                        
                        //*** .pickerStyle choices:  WheelPickerStyle(), SegmentedPickerStyle(), DatePickerStyle(), DateWheelPickerStyle(), DefaultPickerStyle()
                                
//                        Picker(selection: self.$selectedToneIndex, label: Text("Tone")) {
//                            ForEach(0 ..< self.tones.count) {
//                                Text(self.tones[$0])
//
//                            }
//                        }.pickerStyle(DefaultPickerStyle())
                        
                        // TODO: selectedToneIndex is SHARED among all pickers here!!
                        //Picker("Tone", selection: self.$selectedToneIndex, content: {
                        Picker("Tone", selection: self.$cadence.metronomes[i].selectedToneIndex, content: {
                            ForEach(0 ..< self.tones.count) {
                                Text(self.tones[$0])
                            }
                        }).onTapGesture {
                            self.selectedToneIndex = self.cadence.metronomes[i].selectedToneIndex
                            self.cadence.metronomes[i].tone = self.tones[self.selectedToneIndex]

                        }
//                        HStack {
//                            Text("Tempo:").bold()
//                            TextField("Enter Tempo (beat per minute)", text: self.$cadence.metronomes[i].tempo)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                        }
                        HStack {
                            Text("Tempo:").bold()
                            //Slider(value: self.$cadence.metronomes[i].tempo, in: 0...960, step: 60)
                        }.padding(.all, 20)
                        HStack {
                            Text("Repetitions:").bold()
                            Stepper(value: self.$cadence.metronomes[i].repetitions, in: 0...100, step: 1) {
                                Text("\(self.cadence.metronomes[i].repetitions) times")
                            }
                        }
                    }
                }
            }

            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    //self.cadence.metronomes[0].tone = self.tones[self.selectedToneIndex]
                    //self.player.playSound(self.cadence.metronomes[0].tone)
                    self.player.playSound(self.tones[self.selectedToneIndex])
                }, label: {
                    Text("Run").font(.system(size: 24))
                })
                Spacer()
                Button(action: {
                    self.player.stopSound()
                }, label: {
                    Text("Stop").font(.system(size: 24))
                })
                Spacer()
            }.padding(.bottom, 40)
            
        }.navigationBarTitle(Text("\(cadence.name)"))
        .padding(.leading, 20).padding(.trailing, 20)
            .onDisappear {
                self.player.stopSound()
        }
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(name: "1")
//    }
//}
