//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mohamed Jamal Ben Zeglam on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false //for post answer alert (right or wrong)
    @State private var endOfGame = false //for end of game alert after 8 questions
    @State private var scoreTitle = "" //to print correct/wrong in post answer alert
    let endOfGameTitle = "Finished" //to print end of game message
    
    @State private var counter = 1 //counts questions
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var currentScore: Int = 0
    
    @State private var selectedFalgRotate: Int = 5 //arbt value for the selected flag (when run it should take values between 0 and 2, used for rotating animation
    @State private var selectedFalgFade: Int = 5 //arbt value for the selected flag (when run it should take values between 0 and 2, used for fading and scalling animations
    
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
                            FlagImage(flagName: countries[number])
                                .rotation3DEffect(
                                    .degrees(selectedFalgRotate == number ? 360 : 0),
                                    axis: (x: 0, y: 1, z: 0))
                                .animation(.default, value: selectedFalgRotate)
                                .opacity(selectedFalgFade == 5 || selectedFalgFade == number ? 1.0 : 0.25)
                                .scaleEffect(selectedFalgFade == 5 || selectedFalgFade == number ? 1.0 : 0.7)
                                .animation(.default, value: selectedFalgFade) //applies the 3d rotation effect when value is changed
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
        
        .alert(endOfGameTitle, isPresented: $endOfGame){
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(currentScore)/8")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
            selectedFalgRotate = number //here to apply rotation effect only if answer was correct
        } else {
            scoreTitle = "Wrong, this is the flag of \(countries[number])"
        }
        
        counter += 1
        showingScore = true
        selectedFalgFade = number //here not inside if statement, to make fading effect wither we answered correctly or wrong
        
        if counter > 8 {
            endOfGame = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFalgFade = 5 //tp remove fading effect when a new answer show up
    }
    
    func reset() {
        counter = 1
        correctAnswer = Int.random(in: 0...2)
        currentScore = 0
        countries.shuffle()
        selectedFalgRotate = 5
        selectedFalgFade = 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var flagName: String
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original )
            .clipShape(Capsule())
            .shadow(radius: 15)
    }
}
