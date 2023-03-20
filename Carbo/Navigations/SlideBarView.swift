//
//  SlideBarView.swift
//  Carbo
//
//  Created by MarioMang on 2022/9/20.
//

import SwiftUI

struct SlideBarView: View {
    @EnvironmentObject var store: MyStore
    
    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.safeAreaInsets
            
            let size = proxy.size
            
            let width = size.width
            let height = size.height - frame.top
            Divider()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                ForEach(sliderBarItems) { item in
                    SlideBarItemView(item: item)
                        .frame(width: width - 24, height: 32)
                        .padding(.horizontal, 12)
                }
            })
    
            .frame(width: width, height: height)
            .navigationTitle("Slide")
            .toolbar {
                Button {
                        toggleSlideBar()
                } label: {
                    Image(systemName: "sidebar.leading")
                }
            //
            //                Spacer()
            //                Button("400%", action: {
            //                    print("200%")
            //                })
            //                Button("450%", action: {
            //                    print("200%")
            //                })
            }
            .background {
                            Color(.blue)
            }
    
            Text("HHHLKJKJFD")
                .offset(y: height)
        }
    }
    
    private func toggleSlideBar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct SlideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SlideBarView()
    }
}
