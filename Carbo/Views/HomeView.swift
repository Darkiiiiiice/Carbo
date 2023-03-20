//
//  HomeView.swift
//  Carbo
//
//  Created by MarioMang on 2022/9/20.
//

import Foundation
import IOKit.ps
import SwiftUI

class MyStore: ObservableObject {
    @Published var selection: SliderBar = .home
}

struct HomeView: View {
    @StateObject var store = MyStore()

    var body: some View {
        NavigationView {
            SlideBarView()
                .frame(minWidth: 96)

            ContentView()
                .navigationTitle("Content")
                .toolbar {
                    Button("300%", action: {
                        print("200%")
                    })
                }

            DetailView()
                .navigationTitle("Detail")
                .toolbar {
                    Button("200%", action: {
                        print("200%")
                    })
                }
        }
        .background(content: {
            Color(.green)
        })
        .help("Navigation")
        .environmentObject(store)
        .navigationViewStyle(.automatic)
        .navigationSubtitle("MEEE")
        .navigationTitle("Hello")
        .listStyle(.plain)
    
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
