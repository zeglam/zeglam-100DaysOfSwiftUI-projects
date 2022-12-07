//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mohamed Jamal Ben Zeglam on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var currentScore: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack {
                    VStack(spacing: 30) {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            //.foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original )
                                .clipShape(Capsule())
                                .shadow(radius: 15)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Countinue", action: askQuestion)
        } message: {
            Text("Your score is: \(currentScore)")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
