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

    var body: some View {
        
        return VStack {
            HStack {
                Text("Name:").bold()
                TextField("Enter Cadence Name", text: $cadence.name)		
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.top, 40)
//            HStack {
//                Text("Tempo:").bold()
//                Slider(value: $cadence.tempo, in: 0...960, step: 10)
//            }.padding(.all, 20)
            HStack {
                Text("Repetitions:").bold()
                Stepper(value: $cadence.repetitions, in: 0...100, step: 1) {
                    Text("\(cadence.repetitions) times")
                }
            }
//            Divider()
//            List {
//                ForEach ((0..<self.cadence.metronomes.count)) { i in
//                    NavigationLink(destination: DetailsView(cadence: $self.cadences[i])) {
//                        Text("\(self.cadence.metronomes[i].tag)")
//                    }
//                }
//            }

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
                        HStack {
                            Text("Tempo:").bold()
                            TextField("Enter Tempo (beat per minute)", text: self.$cadence.metronomes[i].tempo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Text(self.cadence.metronomes[i].tone)
                        }
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
                    self.player.playSound("BachGavotteShort.mp3")
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
