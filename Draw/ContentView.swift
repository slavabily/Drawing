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

        let finalPosition = CGAffineTransform(translationX: 0, y: -(rect.height / 2))
        
        path = path.applying(finalPosition)

        return path
    }
}

struct ContentView: View {
     
    var body: some View {
        VStack {
            Arrow()
                .fill(Color.blue)
                .frame(width: 200, height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
