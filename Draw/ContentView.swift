//
//  ContentView.swift
//  Draw
//
//  Created by slava bily on 29/3/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        let rectangle = Path(CGRect(origin: rect.origin, size: CGSize(width: rect.width / 2, height: rect.height)))
        
        let position =  CGAffineTransform(translationX: rect.width / 4, y: rect.height)
        
        let rectanglePositioned = rectangle.applying(position)
        
        path.addPath(rectanglePositioned)

        return path
    }
}

struct ColorCyclingRectangle: View {
    var positions: [UnitPoint]
    var startPoint: Int
    
    var unitPoint: UnitPoint {
        return positions[startPoint]
    }
    
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: self.unitPoint, endPoint: .zero),  lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineWidth: CGFloat = 20
    
    @State private var colorcycle = 0.0
    @State private var startPoint = 0
    var positions: [UnitPoint] = [.top, .bottom]
    var positionNames = ["Top", "Bottom"]
    var joo: UnitPoint {
        return positions[startPoint]
    }
       
    var body: some View {
        VStack {
            Arrow()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 100)
            
            Spacer()
            
            Text("Line width")
            Slider(value: $lineWidth, in: 1...40)
                .padding(.bottom)
            
            ColorCyclingRectangle(positions: self.positions, startPoint: self.startPoint, amount: self.colorcycle)
                .frame(width: 200, height: 200)
            
            Text("Color cycling")
                .padding(.top)
            Slider(value: $colorcycle)
 
            Picker(selection: $startPoint, label: Text("Gradient position")) {
                ForEach(0..<self.positions.count) {
                    Text(self.positionNames[$0])
                }
            }
            .padding([.leading])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
