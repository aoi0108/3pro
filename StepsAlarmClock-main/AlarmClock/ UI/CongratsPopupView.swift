//
//  CongratsPopupView.swift
//  AlarmClock
//
//  Created by 平松蒼惟 on 2024/10/09.
//

import SwiftUI

struct CongratsPopupView: View {
    let imageName: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            
            
            Button("Close") {
                // Close the popup
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.beige)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}


