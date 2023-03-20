//
//  QrCode.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/17.
//

import SwiftUI

struct QrCode {
    public static func decode(_ data: Data) -> String {
        if let ciImage = CIImage(data: data) {
            print("CIIAMGE")
            let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
                                      
            if let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: options) {
                print("CIDETECTOR")
                                          
                let features = detector.features(in: ciImage)
                                          
                for item in features where item.isKind(of: CIQRCodeFeature.self) {
                    print((item as! CIQRCodeFeature).messageString ?? "")
                    return (item as! CIQRCodeFeature).messageString ?? ""
                }
            }
        }
        return ""
    }
    
    public static func generate(_ content: String, size: NSSize, foregroundColor: NSColor = .black, backgroundColor: NSColor = .white) -> NSImage? {
        guard let generateFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        // 设置二维码内容
        generateFilter.setValue(content.data(using: .utf8), forKey: "inputMessage")
        // 设置二维码的级别(纠错率) L: 7% M(默认): 15% Q: 25% H: 30%
        generateFilter.setValue("H", forKeyPath: "inputCorrectionLevel")
           
        // 直接返回 UIImage(ciImage: outputImage) 会是模糊的二维码
        guard let outputImage = generateFilter.outputImage else { return nil }

        // 转化为 清晰的图像
        guard let clearImage = generateNonInterpolatedQRCode(outputImage, size: size) else { return nil }
           
        // 设置二维码 颜色
        return setQRCodeColors(clearImage, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
    }
    
    /// 生成清晰的 二维码
    fileprivate static func generateNonInterpolatedQRCode(_ ciImage: CIImage, size: NSSize) -> CGImage? {
        // 调整图片大小及位置（小数跳转为整数）位置值向下调整，大小只向上调整
        let extent = ciImage.extent.integral
        
        // 获取图片大小
        let scale = min(size.width / extent.width, size.height / extent.height)
        let outputImageWidth = extent.width * scale
        let outputImageHeight = extent.height * scale
        
        // 创建依赖于设备的灰度颜色通道
        let space = CGColorSpaceCreateDeviceGray()
        
        // 创建图形上下文
        let bitmapContext = CGContext(data: nil, width: Int(outputImageWidth), height: Int(outputImageHeight), bitsPerComponent: 8, bytesPerRow: 0, space: space, bitmapInfo: 0)
        
        // 设置缩放
        bitmapContext?.scaleBy(x: scale, y: scale)
        // 设置上下文渲染等级
        bitmapContext?.interpolationQuality = .none
        
        // 上下文
        let context = CIContext(options: nil)
        // 创建 cgImage
        guard let cgImage = context.createCGImage(ciImage, from: extent) else { return nil }
            
        // 绘图
        bitmapContext?.draw(cgImage, in: extent)
        
        // 从图形上下文中创建图片
        guard let scaledImage = bitmapContext?.makeImage() else { return nil }
        
        // 返回CGImage
        return scaledImage
    }

    /// 设置二维码前景色 和背景色
    fileprivate static func setQRCodeColors(_ image: CGImage, foregroundColor: NSColor, backgroundColor: NSColor) -> NSImage? {
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        let ciImage = CIImage(cgImage: image)
        let extent = ciImage.extent.integral
        
        // 设置图片
        colorFilter.setValue(ciImage, forKey: "inputImage")
        // 设置前景色
        colorFilter.setValue(CIColor(color: foregroundColor), forKey: "inputColor0")
        // 设置背景色
        colorFilter.setValue(CIColor(color: backgroundColor), forKey: "inputColor1")
        
        // 输出图片
        guard let outputImage = colorFilter.outputImage else { return nil }
        // 上下文
        let context = CIContext(options: nil)
        // 创建 cgImage
        guard let cgImage = context.createCGImage(outputImage, from: extent) else { return nil }
        
        return NSImage(cgImage: cgImage, size: NSSize(width: cgImage.width, height: cgImage.height))
    }
}
