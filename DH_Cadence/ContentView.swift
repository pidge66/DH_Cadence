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
        Cadence(name: "Cadence 1", repetitions: 10, metronomes: []),
//            Metronome(tone: "Tone 1", tempo: 60, repetitions: 4),
//            Metronome(tone: "Tone 2", tempo: 60, repetitions: 7),
//            Metronome(tone: "Tone 3", tempo: 60, repetitions: 8),
//        ]),
        Cadence(name: "Cadence 2", repetitions: 10, metronomes: [])
    ]
        
//    private lazy var count = cadences.count
    
    var body: some View {
        if let i = cadences.firstIndex(of: cadences[1]) {
            print("\(i)")
        }

        return NavigationView {
            VStack {
                Button(action: {
                    self.cadences.append(
                        Cadence(name: "Cadence n", repetitions: 10, metronomes: []))
                    print(self.cadences.count)
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .font(.system(size: 26))
                        
                    }
                })
                Divider()
//                List {
//                    ForEach ((0..<self.cadences.count)) { i in
//                        NavigationLink(destination: DetailsView(cadence: self.$cadences[i])) {
//                            Text("\(self.cadences[i].name)")
//                        }
//                    }
//                }

                List {
                    //ForEach (self.cadences.indices, id: \.self) { i in
                    ForEach (Array(self.cadences.enumerated()), id: \.element.id) { (i, st) in
                        NavigationLink(destination: DetailsView(cadence: self.$cadences[i])) {
                            Text("\(self.cadences[i].name)")
                            Text("\(st.name)")
                        }
                    }
                }
                
//                List {
//                    NavigationLink(destination: DetailsView(cadence: self.$cadences[0])) {
//                        Text("\(cadences[0].name)")
//                    }
//
//                    if self.cadences.count > 2 {
//                        NavigationLink(destination: DetailsView(cadence: self.$cadences[2])) {
//                            Text("\(cadences[2].name)")
//                        }
//                    }
//                }
//                List {
//                    ForEach (cadences, id: \.id) { cadence in
//                        //Text("\(cadence.name)")
//                        NavigationLink(destination:
//                            DetailsView(cadence: self.$cadences[self.cadences.firstIndex(of: cadence)!])) {
//                            Text("\(cadence.name)")
//                        }
//                    }
//                }
//                List {
//                    ForEach (cadences, id: \.id) { cadence in
//                        //Text("\(cadence.name)")
//                        NavigationLink(destination: DetailsView(cadence: $cadence)) {
//                            Text("\(cadence.name)")
//                        }
//                    }
//                }
            }.navigationBarTitle(Text("CADENCES"))
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "plus.circle.fill")
                .font(.system(size: 36))
            }))
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
