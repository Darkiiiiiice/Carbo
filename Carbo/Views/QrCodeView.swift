//
//  QrCodeView.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/18.
//

import SwiftUI

struct QrCodeView: View {
    @State private var text: String = ""
    @State private var image: NSImage = .init()
    @State private var isEditing: Bool = false
    @State private var ch: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            
            let size = proxy.size
            
            let length = min(size.width - 16, size.height)
            
            VStack(alignment: .center, content: {
                Image(nsImage: image)
                    .resizable()
                    .frame(width: length, height: length, alignment: .center)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .stroke(.quaternary, style: StrokeStyle(lineWidth: 0.6))
                    }
                    .cornerRadius(6)
                    .onTapGesture {
                        decodeQrCodeImage()
                        ch.toggle()
                    }
                Spacer()
                Divider()
                    
                TextField("输入后，按Enter结束",text: $text, onEditingChanged: { isEditing = $0 })
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.leading)
                
                    .lineLimit(4)
                    .accentColor(.pink)
                    .foregroundColor(.primary)
                    .font(.title3.weight(.ultraLight))
                    .padding([.horizontal], 8)
                    .onSubmit {
                        let message = self.text
                        if let image = QrCode.generate(message, size: NSSize(width: 500, height: 500)) {
                            self.image = image
                            let pb = NSPasteboard.general

                            pb.clearContents()

                            let objects: [NSPasteboardWriting] = [image]
                            pb.writeObjects(objects)
                        }
                    }
                Divider()
            })
            .padding([.horizontal], 8)
            .padding([.top], 8)
            .submitScope()
        }
    }
    
    private func decodeQrCodeImage() {
        let pb = NSPasteboard.general
        if let image = NSImage(pasteboard: pb) {
            self.image = image
        }
    
        if let items = pb.pasteboardItems {
            for item in items {
                print(item.types)
            
                if let data = item.data(forType: .png) {
                    self.text = QrCode.decode(data)
                } else if var data = item.string(forType: .fileURL) {
                    data.replace("file://", with: "")
                
                    let imageUrl = URL(filePath: data)
                    let image = NSImage(byReferencing: imageUrl)
                    self.image = image
                
                    if let d = image.tiffRepresentation {
                        self.text = QrCode.decode(d)
                    }
                
                } else if let data = item.data(forType: .tiff) {
                    self.text = QrCode.decode(data)
                }
            }
        }
    
        pb.clearContents()
        pb.setString(self.text, forType: .string)
    }
}

struct QrCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeView()
    }
}
