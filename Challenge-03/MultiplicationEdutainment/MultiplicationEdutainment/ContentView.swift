//
//  ContentView.swift
//  MultiplicationEdutainment
//
//  Created by Mohamed Jamal Ben Zeglam on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    
    //gameOn = true if player is playing, false if player setting up game
    @State private var gameON = false
    //list of all mumbers concidered in the game
    @State private var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    @State private var firstNumber = 1
    @State private var secondNumber = 1
    @State private var userAnswer = 0
    //number of queastions player will choose
    @State private var numberOfQuestions = 0
    
    var body: some View {
        VStack {
            Text("Welcome to Multiplication Adventures")
            
            Form {
                Section {
                    Stepper("\(firstNumber)", value: $firstNumber, in: 1...12, step: 1)
                } header: {
                    Text("Select multiplication table")
                }
                
                Section {
                Picker("Select the number of questions", selection: $numberOfQuestions) {
                    ForEach(0..<4, id: \.self) { num in
                        Text("\((num + 1) * 5)")
                    }
                }
                .pickerStyle(.segmented)
                } header: {
                    Text("Select the number of questions")
                }
                
            }
            
            Button("Start the game") {
                //game code
            } .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
