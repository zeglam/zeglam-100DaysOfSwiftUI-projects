//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Mohamed Jamal Ben Zeglam on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .promTitleStyle()
            .padding()
            .background(.orange)
            .padding()
            .background(.purple)
            .padding()
            .background(.orange)
            .padding()
            .background(.purple)
            .padding()
            .background(.orange)
            .padding()
            .background(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PromTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func promTitleStyle() -> some View {
        modifier(PromTitle())
    }
}
