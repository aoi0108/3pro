//
//  SunnyBackGround.swift
//  AlarmClock
//
//  Created by 羽田野真央 on 2024/05/18.
//

import SwiftUI

struct SunnyBackground: View {
    var body: some View {
        ZStack {
            Color.cyan // Clear blue sky

            // Sun
            Circle()
                .fill(Color.yellow)
                .frame(width: 100, height: 100)
                .position(x: 100, y: 100)

            // Clouds
            ForEach(0..<5, id: \.self) { _ in
                Cloud()
                    .opacity(1)
                    .frame(width: 100, height: 60)
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height / 2)
                    )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Cloud: View {
    var body: some View {
        ZStack {
            Ellipse()
                .fill(Color.white)
                .frame(width: 100, height: 60)

            Ellipse()
                .fill(Color.white)
                .frame(width: 70, height: 50)
                .offset(x: -40, y: 10)

            Ellipse()
                .fill(Color.white)
                .frame(width: 70, height: 50)
                .offset(x: 40, y: 10)
        }
    }
}

#Preview {
    SunnyBackground()
}
