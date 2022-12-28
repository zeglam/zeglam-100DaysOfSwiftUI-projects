//
//  ContentView.swift
//  Animations
//
//  Created by Mohamed Jamal Ben Zeglam on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationFactor = 0.0
    @State private var enabled = false
    
    var body: some View {
        VStack {
//            Button("Tape Me") {
//                withAnimation{
//                    animationFactor += 360.0
//                }
//            }
//            .padding(70)
//            .background(.orange)
//            .foregroundColor(.teal)
//            .font(.largeTitle)
//            .clipShape(Circle())
//            .rotation3DEffect(
//                .degrees(animationFactor),
//                axis: (x: 0, y: 0.5, z: 0.5)
//            )
            Button("Tape me now!") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200, alignment: .leading)
            .background(enabled ? .teal : .red)
            .foregroundColor(.gray)
            .animation(.default, value: enabled)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
