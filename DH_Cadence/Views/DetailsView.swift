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
    
    @ObservedObject var player = Player()
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
                    .frame(height: 150)
                
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
                                self.cadence.metronomes.append(Metronome(tone: ArrayCadences.tones[1], selectedToneIndex:1, duration: 1.0, repetitions: 1))
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
                        Text("Duration:").bold()
                        Text(String("\(m.duration.rounded())"))
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
                                self.pickerVisible.toggle()
                                self.player.playSound(self.cadence.metronomes[i].tone)
                            }.foregroundColor(self.pickerVisible && i == self.currentMetronomeIndex ? .red : .blue)
                        }   .padding(.leading, 5)
                            .padding(.trailing, 5)
                        
                        
                        HStack {
                            Text("Duration:").bold()
                            Text(String("\(self.cadence.metronomes[i].duration.rounded())"))
                            Slider(value: self.$cadence.metronomes[i].duration, in: 0.0...60.0, step: 0.50) {_ in  // ?why stepper reverts to 1?!
                                print("\(self.cadence.metronomes[i].duration)")
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
                    .sheet(isPresented: self.$pickerVisible) {
                        VStack{
                            // *** for some reason, Picker alone would cause compiler error?1
                            Text("Current Selection: " + self.cadence.metronomes[i].tone)
                            Picker("", selection: self.$cadence.metronomes[i].selectedToneIndex, content: {
                                ForEach(0 ..< ArrayCadences.tones.count) {
                                    Text(ArrayCadences.tones[$0])
                                }
                            })
                                .onTapGesture {
                                    self.selectedToneIndex = self.cadence.metronomes[i].selectedToneIndex
                                    self.cadence.metronomes[i].tone = ArrayCadences.tones[self.selectedToneIndex]
                                    self.pickerVisible.toggle()
                            }
                        } //VStack
                    } // sheet
                } // ForEach
                
            } // List
        }
    }
    
    var bottomView : some View {
        VStack {
            ProgressBar(value: self.player.percentComplete, maxValue: 100)
                .frame(height: 10)
                .padding(.bottom, 10)
            HStack (spacing: 15) {
                ActivityIndicator(shouldAnimate: self.$player.activityIndicator)

                ProgressCircle(value: self.player.percentComplete,
                           maxValue: 100,
                           style: .line,
                           foregroundColor: .green,
                           lineWidth: 10)
                    .frame(height: 50)
                    .padding(-10)
                
                Spacer()
                Button(action: {
                    self.player.playCadence(self.cadence)
                }) {
                    Image(systemName: "playpause")
                }
                Spacer()
                Button(action: {
                    self.player.pauseCadence()
                }) {
                    Image(systemName: "pause")
                }
                Spacer()
                Button(action: {
                    self.player.stopCadence()
                }) {
                    Image(systemName: "stop")
                    //Image("icons8-stop")
                }
                Spacer()
            }//.padding(.bottom, 40)
        }
    }
    
    func delete(at offsets: IndexSet) {
        // *** if bindings are involved within each row view, this will cause out of range error
        cadence.metronomes.remove(atOffsets: offsets)
        
        //        guard let index = offsets.first else {return}
        //        cadence.metronomes.remove(at: index)
    }
    
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct ProgressBar: View {
    private let value: Double
    private let maxValue: Double
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    
    init(value: Double,
         maxValue: Double,
         backgroundEnabled: Bool = true,
         backgroundColor: Color = Color(UIColor(red: 245/255,
                                                green: 245/255,
                                                blue: 245/255,
                                                alpha: 1.0)),
         foregroundColor: Color = Color.baseRed) {
        self.value = value
        self.maxValue = maxValue
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    var body: some View {
        // 1
        ZStack {
            // 2
            GeometryReader { geometryReader in
                // 3
                if self.backgroundEnabled {
                    Capsule()
                        .foregroundColor(self.backgroundColor) // 4
                }
                    
                Capsule()
                .frame(width: self.progress(value: self.value,
                                            maxValue: self.maxValue,
                                            width: geometryReader.size.width))
                .foregroundColor(self.foregroundColor)
                .animation(.easeIn)
            }
        }
    }
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

struct ProgressCircle: View {
    enum Stroke {
        case line
        case dotted
        
        func strokeStyle(lineWidth: CGFloat) -> StrokeStyle {
            switch self {
            case .line:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round)
            case .dotted:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round,
                                   dash: [12])
            }
        }
    }
    
    private let value: Double
    private let maxValue: Double
    private let style: Stroke
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let lineWidth: CGFloat
    
    init(value: Double,
         maxValue: Double,
         style: Stroke = .line,
         backgroundEnabled: Bool = true,
         backgroundColor: Color = Color(UIColor(red: 245/255,
                                                green: 245/255,
                                                blue: 245/255,
                                                alpha: 1.0)),
         foregroundColor: Color = Color.black,
         lineWidth: CGFloat = 10) {
        self.value = value
        self.maxValue = maxValue
        self.style = style
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.lineWidth = lineWidth
    }
    var body: some View {
        ZStack {
            if self.backgroundEnabled {
                Circle()
                    .stroke(lineWidth: self.lineWidth)
                    .foregroundColor(self.backgroundColor)
            }
            
            Circle()
                .trim(from: 0, to: CGFloat(self.value / self.maxValue))
                .stroke(style: self.style.strokeStyle(lineWidth: self.lineWidth))
                .foregroundColor(self.foregroundColor)
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeIn)
        }
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(name: "1")
//    }
//}
