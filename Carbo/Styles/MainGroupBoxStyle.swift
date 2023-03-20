//
//  MainGroupBoxStyles.swift
//  Carbo
//
//  Created by MarioMang on 2022/9/22.
//

import SwiftUI

struct MainGroupBoxStyle: GroupBoxStyle {
//    var background: some View {
//        RoundedRectangle(cornerRadius: 5)
////            .fill(Color.orange)
//    }

    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.headline.bold())
            .padding(.all, 8)
        configuration.content
            .padding()
    }
}
