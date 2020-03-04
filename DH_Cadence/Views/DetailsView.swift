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
    @State private var editMode = false
    
    var body: some View {
        
        return VStack {
            
            headingView
            
            if (editMode) {
                editView
            } else {
                displayView
                Spacer()
                bottomView
            }
            
        }.navigationBarTitle(Text("\(cadence.name)"))
            .padding(.leading, 10).padding(.trailing, 10)
        //            .onDisappear {
        //                self.player.stopSound()
        //        }
    }
    
    var headingView : some View {
        VStack {
            HStack {
                Text("Name:").bold()
                TextField("Enter Cadence Name", text: $cadence.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }.padding(.top, 5    )
            
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
                    self.editMode.toggle()
                }, label: {
                    if editMode {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.cadence.metronomes.append(Metronome(tone: ArrayCadences.tones[1], selectedToneIndex:1, tempo: 60.0, repetitions: 1))
                            }, label: {
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 36))
                                
                            })
                            Text("Done").font(.system(size: 24))
                        }
                    } else {
                        Text("Edit").font(.system(size: 24))
                    }
                })
            }
        }
        
    }
    
    var displayView : some View {
        List {
            ForEach (cadence.metronomes) { m in
                VStack {
                    HStack {
                        Text("Tone:").bold()
                        Text(m.tone)
                        Spacer()
                    }   .padding(.leading, 5)
                        .padding(.trailing, 5)

                    HStack {
                        Text("Tempo:").bold()
                        Text(String("\(m.tempo.rounded())"))
                        Spacer()
                    }   .padding(.leading, 5)
                        .padding(.trailing, 5)
                    
                    HStack {
                        Text("Repetitions:").bold()
                        Text("\(String(m.repetitions)) times")
                        Spacer()
                    }.padding(.bottom, 20)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)

                }
                .padding(.top, 10)
                .background(Color.baseRockBlue)
                
            } // ForEach
                .onDelete(perform: delete)

        } // List
    }
    
    var editView : some View {
        VStack {
            List {
                //ForEach (Array(self.myCadences.cadences.enumerated()), id: \.element.id) { (i, cadence) in
                ForEach (cadence.metronomes.indices, id: \.self) { i in
                    VStack {
                        HStack {
                            Text("Tone:").bold()
                            TextField("Enter Tone Name", text: self.$cadence.metronomes[i].tone)
                                .textFieldStyle(RoundedBorderTextFieldStyle()).opacity(0.5)
                            
                            Button(self.pickerVisible && i == self.currentMetronomeIndex ? "Done" : "Select"){
                                self.currentMetronomeIndex = i
                                if self.pickerVisible {
                                    self.selectedToneIndex = self.cadence.metronomes[i].selectedToneIndex
                                    self.cadence.metronomes[i].tone = ArrayCadences.tones[self.selectedToneIndex]
                                }
                                self.pickerVisible.toggle()
                                self.player.playSound(self.cadence.metronomes[i].tone)
                            }.foregroundColor(self.pickerVisible && i == self.currentMetronomeIndex ? .red : .blue)
                        }   .padding(.leading, 5)
                            .padding(.trailing, 5)
                        
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
                        
                        HStack {
                            Text("Tempo:").bold()
                            Text(String("\(self.cadence.metronomes[i].tempo.rounded())"))
                            Slider(value: self.$cadence.metronomes[i].tempo, in: 30...480, step: 30) {_ in
                                print("\(self.cadence.metronomes[i].tempo)")
                            }
                            Spacer()
                        }   .padding(.leading, 5)
                            .padding(.trailing, 5)
                        
                        HStack {
                            Text("Repetitions:").bold()
                            Stepper(value: self.$cadence.metronomes[i].repetitions, in: 0...100, step: 1) {
                                Text("\(self.cadence.metronomes[i].repetitions) times")
                            }
                        }.padding(.bottom, 20)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                        
                    }
                    .animation(Animation.easeInOut(duration: self.pickerVisible ? 0.5 : 0))
                    .padding(.top, 10)
                    .background(Color.baseRockBlue)
                    
                } // ForEach
                
            } // List
        }
    }
    
    var bottomView : some View {
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
                self.player.stopCadence()
            }, label: {
                Text("Stop").font(.system(size: 24))
            })
            Spacer()
        }.padding(.bottom, 40)
    }
    
    func delete(at offsets: IndexSet) {
        // *** if bindings are involved within each row view, this will cause out of range error
        cadence.metronomes.remove(atOffsets: offsets)
        
        //        guard let index = offsets.first else {return}
        //        cadence.metronomes.remove(at: index)
    }
    
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(name: "1")
//    }
//}
