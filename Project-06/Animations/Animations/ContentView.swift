//
//  ContentView.swift
//  Animations
//
//  Created by Mohamed Jamal Ben Zeglam on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationFactor = 0.0
    
    var body: some View {
        VStack {
            Button("Tape Me") {
                withAnimation{
                    animationFactor += 360.0
                }
            }
            .padding(70)
            .background(.orange)
            .foregroundColor(.teal)
            .font(.largeTitle)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(animationFactor),
                axis: (x: 0, y: 0.5, z: 0.5)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
