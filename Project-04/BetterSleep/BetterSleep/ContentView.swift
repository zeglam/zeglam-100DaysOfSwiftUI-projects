//
//  ContentView.swift
//  BetterSleep
//
//  Created by Mohamed Jamal Ben Zeglam on 12/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Spacer()
            
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...11, step: 0.25)
            
            Spacer()
            
            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute) 
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
