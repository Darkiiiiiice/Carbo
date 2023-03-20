//
//  ColorPickerView.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/22.
//

import SwiftUI

struct ColorPickerView: View {
    @State private var image: NSImage = .init()
    
    @State private var globalMouseMonitor: Any?
    @State private var localMouseMonitor: Any?
    @State private var startColorPick = false
    @State private var settings: PickerSettings = .init()
    @State private var color: NSColor? = NSColor.gridColor.usingColorSpace(.deviceRGB)
    
    var body: some View {
        Grid(alignment: .center, content: {
            GridRow {
                Image(nsImage: self.image)
                    .resizable()
                    .frame(alignment: .center)
                    .padding(.all, 2)
                    .cornerRadius(6)
                    .overlay {
                        Rectangle()
                            .fill(.primary.opacity(0.6))
                            .frame(width: 8, height: 8)
                    }
                    .background(content: {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .stroke(.primary, style: StrokeStyle(lineWidth: 0.2))
                            
                    })
                    .onTapGesture {
                        print("Hello")
                        self.startColorPick.toggle()
                            
                        if startColorPick {
                            settings.colorspace()
                            settings.displaymode()
                            
                            self.globalMouseMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved], handler: { event in
                                self.mouseEventHandler(event)
                            })
                            
                            self.localMouseMonitor = NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved], handler: { event in
                                self.mouseEventHandler(event)
                                return nil
                            })
                            
                        } else {
                            if self.globalMouseMonitor != nil {
                                NSEvent.removeMonitor(self.globalMouseMonitor!)
                                self.globalMouseMonitor = nil
                            }
                            if self.localMouseMonitor != nil {
                                NSEvent.removeMonitor(self.localMouseMonitor!)
                                self.localMouseMonitor = nil
                            }
                        }
                    }
                    
                Grid {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .background {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .stroke(.primary, style: StrokeStyle(lineWidth: 0.2))
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color((self.color ?? .clear).usingColorSpace(settings.colorSpace) ?? .clear))
                        }
//                        .padding(.all, 8)
                        
                    RoundedRectangle(cornerSize: .init(width: 12, height: 12), style: .continuous)
//                        .fill(.red)
                        .shadow(color: .white, radius: 2)
                }
                .background {
                    Color(.clear)
                }
            }
            .padding([.all], 8)
          
        })
    }
    
    func mouseEventHandler(_ event: NSEvent) {
        // Mouse location
        guard let mouseLoc = CGEvent(source: nil)?.location else {
            return
        }
        // Display mouse is on
        var count: UInt32 = 0
        var displayForPoint: CGDirectDisplayID = .zero
        if CGGetDisplaysWithPoint(NSPointToCGPoint(mouseLoc), 1, &displayForPoint, &count) != CGError.success {
            // ERROR!
            print("Failed to get display")
        } else {
            // Get color at mouseLoc
            if let image = CGDisplayCreateImage(displayForPoint, rect: CGRect(x: mouseLoc.x, y: mouseLoc.y, width: 1, height: 1)), let prevImage = CGDisplayCreateImage(displayForPoint, rect: CGRect(x: mouseLoc.x - 16, y: mouseLoc.y - 16, width: 32, height: 32)) {
                let bitmap = NSBitmapImageRep(cgImage: image)
                if let bitColor = bitmap.colorAt(x: 0, y: 0) {
                    let components = UnsafeMutablePointer<CGFloat>.allocate(capacity: bitColor.numberOfComponents)
                    bitColor.getComponents(components)
                    
                    self.color = NSColor(colorSpace: bitmap.colorSpace, components: components, count: bitColor.numberOfComponents).usingColorSpace(settings.colorSpace)
                    print(self.color)
                }
//                self.image = prevImage
                self.image = NSImage(cgImage: prevImage, size: NSSize(width: prevImage.width, height: prevImage.height))
            }
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}
