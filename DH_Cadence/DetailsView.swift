//
//  DetailsView.swift
//  DH_Cadence
//
//  Created by David Hou on 2/10/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import SwiftUI
import UIKit

struct DetailsView: View {
    
    @Binding var cadence: Cadence
    @State private var text = ""

    var body: some View {
        VStack {
            HStack {
                Text("Name:").bold()
                TextField("Enter Cadence Name", text: $cadence.name)
                    .background(Color(UIColor.lightGray))
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

            Spacer()
            HStack {
                Button(action: {}, label: {
                    Text("Run").font(.system(size: 24))

                })

            }
        }.navigationBarTitle(Text("\(cadence.name)"))
        .padding(.leading, 20).padding(.trailing, 20)
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(name: "1")
//    }
//}
