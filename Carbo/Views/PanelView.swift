//
//  PanelView.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/18.
//

import Charts
import CoreGraphics
import SwiftUI

struct ToyShape: Identifiable {
    var color: String
    var type: String
    var count: Double
    var id = UUID()
}

struct PanelView: View {
    @Binding var page: Int
    
//    @State private var color =
//        Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var date = Date()
    
    var stackedBarData: [ToyShape] = [
        .init(color: "Green", type: "Cube", count: 2),
        .init(color: "Green", type: "Sphere", count: 0),
        .init(color: "Green", type: "Pyramid", count: 1),
        .init(color: "Purple", type: "Cube", count: 1),
        .init(color: "Purple", type: "Sphere", count: 1),
        .init(color: "Purple", type: "Pyramid", count: 1),
        .init(color: "Pink", type: "Cube", count: 1),
        .init(color: "Pink", type: "Sphere", count: 2),
        .init(color: "Pink", type: "Pyramid", count: 0),
        .init(color: "Yellow", type: "Cube", count: 1),
        .init(color: "Yellow", type: "Sphere", count: 1),
        .init(color: "Yellow", type: "Pyramid", count: 2),
    ]
    
    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 8, verticalSpacing: 12) {
            GridRow(alignment: .center) {
                Grid {
                    QrCodeView()
                        .padding(.all)
                }
                .background {
                    RoundedRectangle(cornerRadius: 6, style: .circular)
                        .fill(.ultraThinMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .stroke(.primary, style: StrokeStyle(lineWidth: 0.2))
                        }
//                        .shadow(color: .black, radius: 1)
                }
                
//                Grid {
//                    ColorPickerView()
//                        .background {
//                            RoundedRectangle(cornerRadius: 6, style: .circular)
//                                .fill(.ultraThinMaterial)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
//                                        .stroke(.primary, style: StrokeStyle(lineWidth: 0.2))
//                                }
//                        }
//
////                    RoundedRectangle(cornerSize: .init(width: 12, height: 12), style: .continuous)
////                        .fill(.ultraThinMaterial)
////                        .shadow(color: .white, radius: 2)
////                        .overlay(content: {
////
////                            if image != nil {
////                            Image(decorative: image!, scale: 1)
////                                .scaleEffect(2)
////                                .frame(width: 70, height: 70)
////
////
////                                Rectangle()
////                                    .frame(width: 5, height: 5)
////                                    .background(Color((color ?? .clear).usingColorSpace(settings.colorSpace) ?? .clear))
////                                    .border(Color.white, width: 1)
////                            }
////                        })
////                        .onAppear() {
//
////                        }
//                    RoundedRectangle(cornerSize: .init(width: 12, height: 12), style: .continuous)
//                        .fill(.thinMaterial)
//                        .shadow(color: .white, radius: 2)
//                }
//            }
//            .padding([.top, .bottom], 24)
            
//            GridRow(alignment: .center) {
//                Grid {
//                    RoundedRectangle(cornerSize: .init(width: 12, height: 12), style: .continuous)
//                        .fill(.thickMaterial)
//                        .shadow(color: .white, radius: 2)
//                }
//                   
//                Grid {
//                    Chart {
//                        ForEach(stackedBarData) { shape in
//                            BarMark(
//                                x: .value("Shape Type", shape.type),
//                                y: .value("Total Count", shape.count)
//                            )
//                            .foregroundStyle(by: .value("Shape Color", shape.color))
//                        }
//                    }
//
//                    RoundedRectangle(cornerSize: .init(width: 12, height: 12), style: .continuous)
//                        .fill(.gray)
//                        .border(.blue)
//                }
            }
        }
        .padding([.leading, .trailing], 12)
        .frame(width: 300, height: 300)
        .onAppear {
            print("Appear")
        }
    }
}

struct PanelView_Previews: PreviewProvider {
    @State var page = 1
    
    static var previews: some View {
        PanelView(page: .constant(1))
    }
}
