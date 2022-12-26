//
//  ContentView.swift
//  Animations
//
//  Created by Mohamed Jamal Ben Zeglam on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationFactor = 1.0
    
    var body: some View {
        VStack {
            Stepper("Scale Amount", value: $animationFactor.animation(), in: 1...10)
            
            Spacer()
            
            Button("Tape Me") {
                animationFactor += 1
            }
            .padding(30)
            .background(.blue)
            .foregroundColor(.orange)
            .clipShape(Circle())
            .scaleEffect(animationFactor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
