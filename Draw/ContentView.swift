//
//  ContentView.swift
//  Draw
//
//  Created by slava bily on 29/3/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct Rectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(rect)
        
        return path
    }
}

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

struct ContentView: View {
    @State private var lineWidth: CGFloat = 20
     
    var body: some View {
        VStack {
            Arrow()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
            
            Spacer(minLength: 50)
            
            Slider(value: $lineWidth, in: 1...40)
                .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
