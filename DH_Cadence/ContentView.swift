//
//  ContentView.swift
//  DH_Cadence
//
//  Created by David Hou on 2/7/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        
        let m: [Metronome] = [
            Metronome(tone: "Tone 1", tempo: 60, repetitions: 4),
            Metronome(tone: "Tone 2", tempo: 60, repetitions: 7),
            Metronome(tone: "Tone 3", tempo: 60, repetitions: 8),
            ]

        let cadences: [Cadence] = [
            Cadence(name: "Cadence 1", repetitions: 10, metronomes: m),
            Cadence(name: "Cadence 2", repetitions: 10, metronomes: m)
        ]

        //print(c)
        
        return NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.system(size: 26))
                    
                }.padding(.bottom, 20)
                Divider()
                List {
                    ForEach (cadences) { cadence in
                        NavigationLink(destination: Text("\(cadence.name)")) {
                            Text("\(cadence.name)")
                        }
                    }
                }.navigationBarTitle(Text("CADENCES"))
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
