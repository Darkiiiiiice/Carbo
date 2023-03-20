//
//  SlideBarItemView.swift
//  Carbo
//
//  Created by MarioMang on 2022/9/21.
//

import SwiftUI

struct SlideBarItemView: View {
    @EnvironmentObject var store: MyStore
    
    let item: SliderBarItem
    
    var body: some View {
        GeometryReader { proxy in
            
            let frame = proxy.safeAreaInsets
            
            let size = proxy.size
            
            let width = size.width
            let height = size.height - frame.top
            
            Button {
                store.selection = item.slide
            } label: {
                Image(systemName: item.icon)
//                    .border(.selection, width: 1)
                    .font(.largeTitle)
//                Spacer()
                Text(item.title)
                    .font(.caption2)
//                    .lineLimit(1)
                Spacer()
            }
            .frame(alignment: .leading)
            .buttonStyle(.link)
            .padding(.bottom, 0)
//            .border(.yellow, width: 2)
//            .frame(width: width)
            .background {
                RoundedRectangle(cornerSize: CGSize(width: 6, height: 6), style: .continuous)
                    .fill(.red)
            }

        }
        .padding(.bottom, 0)
    }
}
