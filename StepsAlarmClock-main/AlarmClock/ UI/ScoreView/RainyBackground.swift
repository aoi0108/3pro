//
//  RainyBackground.swift
//  AlarmClock
//
//  Created by 羽田野真央 on 2024/05/18.
//
import SwiftUI

struct RainyBackground: View {
    @State private var startAnimation: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.blue.opacity(0.3) // Light blue background for the sky
                
                // Overlaying rain drop shapes
                ForEach(0..<100, id: \.self) { index in
                    RainDrop()
                        .opacity(0.7)
                        .frame(width: 5, height: 15)
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: startAnimation ? geometry.size.height : -15
                        )
                        .animation(
                            Animation.linear(duration: Double.random(in: 1...2))
                                .repeatForever(autoreverses: false)
                                .delay(Double.random(in: 0...1))
                        )
                }
            }
            .onAppear {
                startAnimation = true
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RainDrop: View {
    var body: some View {
        Capsule()
            .fill(Color.blue)
    }
}

#Preview {
    RainyBackground()
}
