//
//  ContentView.swift
//  DH_Cadence
//
//  Created by David Hou on 2/7/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ContentView: View {
//    @State var cadences: [Cadence] = [Cadence(name: "Cadence 1", repetitions: 10, metronomes: []),
//                          Cadence(name: "Cadence 2", repetitions: 10, metronomes: [])]
//    @ObservedObject var cadences: [Cadence] = [
//        Cadence(name: "Cadence 2", repetitions: 10, metronomes: [])
//    ]
        
//    private lazy var count = cadences.count
    @ObservedObject var myCadences :ArrayCadences = ArrayCadences()
    @State var myStateText = ""
    
    var body: some View {

        return NavigationView {
            List {
                //ForEach (Array(self.myCadences.cadences.enumerated()), id: \.element.id) { (i, cadence) in
                ForEach (self.myCadences.cadences.indices, id: \.self) { i in
                    // *** Can't pass cadence as binding!  so need index and thus requires id
                    // *** Also, the array itself must be Observable, not just its elements
                    NavigationLink(destination: DetailsView(cadence: self.$myCadences.cadences[i])) {
                        //Text("\(cadence.name)")
                        Text("\(self.myCadences.cadences[i].name)")
                    }
                    
                }
            }
            .navigationBarTitle(Text("CADENCES"))
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .navigationBarItems(trailing: Button(action: {
                self.myCadences.cadences.append(
                    Cadence(name: "<New Cadence>", repetitions: 10, metronomes: []))
                print(self.myCadences.cadences.count)
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
