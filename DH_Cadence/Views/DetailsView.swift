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
    @State private var currentMetronomeIndex = 0
    @State private var pickerVisible = false

    var body: some View {
        
        return VStack {
            HStack {
                Text("Name:").bold()
                TextField("Enter Cadence Name", text: $cadence.name)		
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }.padding(.top, 5	)
                        
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

                            Button(self.pickerVisible ? "Done" : "Select"){
                                self.currentMetronomeIndex = i
                                if self.pickerVisible {
                                    self.selectedToneIndex = self.cadence.metronomes[i].selectedToneIndex
                                    self.cadence.metronomes[i].tone = ArrayCadences.tones[self.selectedToneIndex]
                                }
                                self.pickerVisible.toggle()
                            }.foregroundColor(self.pickerVisible ? .red : .blue)
                        }
                        
                        //Picker("Tone", selection: self.$selectedToneIndex, content: {
                        if self.pickerVisible && i == self.currentMetronomeIndex {
                            Picker("", selection: self.$cadence.metronomes[i].selectedToneIndex, content: {
                                ForEach(0 ..< ArrayCadences.tones.count) {
                                    Text(ArrayCadences.tones[$0])
                                }
                            }).onTapGesture {
                                self.selectedToneIndex = self.cadence.metronomes[i].selectedToneIndex
                                self.cadence.metronomes[i].tone = ArrayCadences.tones[self.selectedToneIndex]
                                self.pickerVisible.toggle()
                            }
                        }
                        //.animation(Animation.easeInOut(duration: 2))

                        HStack {
                            Text("Tempo:").bold()
                            Text(String("\(self.cadence.metronomes[i].tempo.rounded())"))
                            Slider(value: self.$cadence.metronomes[i].tempo, in: 30...480, step: 30) {_ in
                                print("\(self.cadence.metronomes[i].tempo)")
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Text("Repetitions:").bold()
                            Stepper(value: self.$cadence.metronomes[i].repetitions, in: 0...100, step: 1) {
                                Text("\(self.cadence.metronomes[i].repetitions) times")
                            }
                        }.padding(.bottom, 20)
                    }
                    .animation(Animation.easeInOut(duration: 1))

                }
            }

            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    //self.player.playSound(ArrayCadences.tones[self.selectedToneIndex])
                    self.player.playCadence(self.cadence)
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
//        .padding(.leading, 20).padding(.trailing, 20)
//            .onDisappear {
//                self.player.stopSound()
//        }
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(name: "1")
//    }
//}