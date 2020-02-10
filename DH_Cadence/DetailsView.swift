//
//  DetailsView.swift
//  DH_Cadence
//
//  Created by David Hou on 2/10/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    
    var name: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {}, label: {
                    Text("Run").font(.system(size: 24))

                })
                //.frame(width: 200, height: 80, alignment: .center)
                //.background(Color.gray)
                //.buttonStyle(PlainButtonStyle())

            }
        }.navigationBarTitle(Text("\(name)"))
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(name: "1")
    }
}
