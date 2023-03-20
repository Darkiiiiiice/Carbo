//
//  SlideBar.swift
//  Carbo
//
//  Created by MarioMang on 2022/9/21.
//

import SwiftUI

struct SliderBarItem: Identifiable {
    var id = UUID()

    var title: String
    var icon: String
    
    var slide: SliderBar
}


enum SliderBar: String {
    case home
    case page
    case detail
}


var sliderBarItems = [
    SliderBarItem(title: "Home", icon: "house", slide: .home),
    SliderBarItem(title: "Page", icon: "house", slide: .page),
    SliderBarItem(title: "Detail", icon: "house", slide: .detail),
]
