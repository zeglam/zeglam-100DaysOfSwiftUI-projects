//
//  ContentView.swift
//  Animations
//
//  Created by Mohamed Jamal Ben Zeglam on 12/26/22.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    
//    @State private var animationFactor = 0.0
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//    let letters = Array("Hello, SwiftUI")
    
    @State private var isShowingRed = false
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(.mint)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        
        
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) {
//                num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .teal : .red)
//                    .offset(dragAmount)
//                    .animation(
//                        .default.delay(Double(num) / 20),
//                        value: dragAmount
//                    )
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged {
//                    dragAmount = $0.translation
//                }
//                .onEnded {
//                    _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
        
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
