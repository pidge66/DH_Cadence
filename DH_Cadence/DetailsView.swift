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
        VStack {
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

            Spacer()
            HStack {
                Button(action: {
                    self.player.playSound()
                }, label: {
                    Text("Run").font(.system(size: 24))

                })

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
