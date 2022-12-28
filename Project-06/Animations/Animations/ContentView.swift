//
//  ContentView.swift
//  Animations
//
//  Created by Mohamed Jamal Ben Zeglam on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    
//    @State private var animationFactor = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello, SwiftUI")
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<letters.count) {
                num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .teal : .red)
                    .offset(dragAmount)
                    .animation(
                        .default.delay(Double(num) / 20),
                        value: dragAmount
                    )
            }
        }
        .gesture(
            DragGesture()
                .onChanged {
                    dragAmount = $0.translation
                }
                .onEnded {
                    _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
        
//        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200, alignment: .leading)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged {
//                        dragAmount = $0.translation
//                    }
//                    .onEnded { _ in
//                        withAnimation {
//                        dragAmount = .zero
//                        }
//                    }
//            )
//            .animation(.spring(), value: dragAmount)
        
        
//        VStack {
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
            
            
//            Button("Tape me now!") {
//                enabled.toggle()
//            }
//            .frame(width: 200, height: 200, alignment: .leading)
//            .background(enabled ? .teal : .red)
//            .foregroundColor(.gray)
//            .animation(.default, value: enabled)
//            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
            
            
            
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
