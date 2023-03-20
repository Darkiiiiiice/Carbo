//
//  MenuBarView.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/17.
//

import CoreImage.CIFilterBuiltins
import SwiftUI
import UniformTypeIdentifiers

struct MenuBarView: View {
    
    
    var settings = PickerSettings()
    
    @State var page = 1
    
    var body: some View {
        HomeGridView()
    }
    
    @ViewBuilder
    func HomeGridView() -> some View {
        Grid {
            if page == 1 {
                PanelView(page: $page)
                    .environmentObject(settings)
            } else if page == 2 {
                HomeView()
            }
        }
    }
    
    
    
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
