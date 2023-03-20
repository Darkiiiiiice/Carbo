//
//  ToolbarView.swift
//  Carbo
//
//  Created by MarioMang on 2022/9/20.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        Button {
            print("Hello tool bar")
        }
        label: {
            Image(systemName: "sidebar.squares.leading")
                .symbolVariant(.circle.fill)
                .font(.title3)
                .foregroundColor(.secondary)
                .imageScale(.large)
        }

//        GeometryReader { proxy in
//
//            let global = proxy.frame(in: .global)

//            HStack(alignment: .center, spacing: 8){
//                Label("Hello", systemImage: "circle")
//                    .frame(alignment: .leading)
//                Spacer()
//                Label("World", systemImage: "square")
//
//                Spacer()
//                Label("World", systemImage: "rectangle.on.rectangle")
//                    .frame(alignment: .trailing)
//
//                Button {
//                    let frame = proxy.frame(in: .local)
//
//                    let minX = frame.minX
//                    let minY = frame.minY
//                    let maxX = frame.maxX
//                    let maxY = frame.maxY
//                    let midX = frame.midX
//                    let midY = frame.midY
//                    let width = frame.width
//                    let height = frame.height
//
//                    print("minX = \(minX)")
//                    print("minY = \(minY)")
//                    print("maxX = \(maxX)")
//                    print("maxY = \(maxY)")
//                    print("midX = \(midX)")
//                    print("midY = \(midY)")
//                    print("width = \(width)")
//                    print("height = \(height)")
//                } label: {
//                    Label("HLLLE", systemImage: "square")
//                }
//                .frame(alignment: .topLeading)
//            }
//        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}
