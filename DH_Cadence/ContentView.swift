//
//  ContentView.swift
//  DH_Cadence
//
//  Created by David Hou on 2/7/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State private var cadences: [Cadence] = [
        Cadence(name: "Cadence 1", repetitions: 10, metronomes: [
            Metronome(tone: "Tone 1", tempo: 60, repetitions: 4),
            Metronome(tone: "Tone 2", tempo: 60, repetitions: 7),
            Metronome(tone: "Tone 3", tempo: 60, repetitions: 8),
        ]),
        Cadence(name: "Cadence 2", repetitions: 10, metronomes: [
            Metronome(tone: "Tone 1", tempo: 60, repetitions: 4),
            Metronome(tone: "Tone 2", tempo: 60, repetitions: 7),
            Metronome(tone: "Tone 3", tempo: 60, repetitions: 8),
        ])
    ]
    
    var body: some View {
        return NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.system(size: 26))
                    
                }.padding(.bottom, 20)
                Divider()
                List {
                    ForEach ((0..<self.cadences.count)) { i in
                        NavigationLink(destination: DetailsView(cadence: self.$cadences[i])) {
                            Text("\(self.cadences[i].name)")
                        }
                    }
                }.navigationBarTitle(Text("CADENCES"))
                
//                List {
//                    ForEach (cadences, id: \.self) { cadence in
//                        NavigationLink(destination: DetailsView(cadence: $cadence)) {
//                            Text("\(cadence.name)")
//                        }
//                    }
//                }.navigationBarTitle(Text("CADENCES"))
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
