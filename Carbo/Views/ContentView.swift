//
//  ContentView.swift
//  Carbo
//
//  Created by MarioMang on 2022/9/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: MyStore
    var body: some View {
        if store.selection == .home {
            Text("Home")
        } else if store.selection == .page{
            Text("Page")
        } else if store.selection == .detail {
            Text("Detail")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
