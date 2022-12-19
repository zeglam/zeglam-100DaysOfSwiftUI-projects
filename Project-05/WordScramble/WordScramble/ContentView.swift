//
//  ContentView.swift
//  WordScramble
//
//  Created by Mohamed Jamal Ben Zeglam on 12/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section("Sec 1") {
                Text("Static Row Number 1")
            }

            Section("Sec2") {
                ForEach(0..<3) {
                    Text("Dynamic Row Number \($0)")
                }
            }
            
            Section("Sec 3") {
                Text("Static Row Number 2")
            }
        }
        .listStyle(.grouped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
