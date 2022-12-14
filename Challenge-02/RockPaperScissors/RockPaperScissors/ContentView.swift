//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mohamed Jamal Ben Zeglam on 12/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var handList = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var desiredOutcome = Bool.random() //true=win, false=lose
    @State private var playerHand = ""
    @State private var roundCounter = 1
    @State private var finalScore = 0
    @State private var currentScore = 0
    @State private var showingScore = false
    @State private var endOfGame = false

    var machineHand: String {
        switch self.handList[0] {
            case "Rock":
                return "square.fill"
            case "Paper":
                return "paperplane"
            case "Scissors":
                return "scissors"
            default:
                return ""
        }
    }
    
    var machineHandNumber: Int {
        switch self.handList[0] {
            case "Rock":
                return 0
            case "Paper":
                return 1
            default: //case of scissors
                return 2
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mint, .gray], startPoint: .top, endPoint: .bottom)
            
            Spacer()
            
            VStack {
                
                Spacer()
                
                Text("Rock Paper Scissors")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.primary)
                    .padding()
                                
                Text("The machine has chosen:")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding()
                
                Image(systemName: machineHand)
                    .font(.largeTitle.weight(.thin))
                    .foregroundColor(.primary)
                
                Text("And it wants you to:")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding()
                
                Text(desiredOutcome ? "Win" : "Lose")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.primary)
                    .padding()
                                
                Text("Choose your hand:")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding()
                
                HStack {
                    Spacer()
                    ForEach(0..<3) { number in
                        Button {
                            handPicked(number)
                        } label: {
                            HandImage(handNum: number)
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                Text("Your score is \(currentScore)")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding()
            }
            .padding(.vertical)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .alert("Round Result", isPresented: $showingScore) {
            Button("Countinue", action: anotherRound)
        } message: {
            Text("Your score is: \(currentScore)")
        }
                
        .alert("Game Finished", isPresented: $endOfGame){
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(currentScore)/10")
        }
        
    }
    
    func handPicked(_ handNumber: Int) {
        if (machineHandNumber == handNumber) {
            currentScore -= 1
        } else if (machineHandNumber == 0) && (handNumber == 1) && (desiredOutcome == true) {
            currentScore += 1
        } else if (machineHandNumber == 1) && (handNumber == 2) && (desiredOutcome == true) {
            currentScore += 1
        } else if (machineHandNumber == 2) && (handNumber == 0) && (desiredOutcome == true) {
            currentScore += 1
        } else if (machineHandNumber == 0) && (handNumber == 2) && (desiredOutcome == false) {
            currentScore += 1
        } else if (machineHandNumber == 1) && (handNumber == 0) && (desiredOutcome == false) {
            currentScore += 1
        } else if (machineHandNumber == 2) && (handNumber == 1) && (desiredOutcome == false) {
            currentScore += 1
        } else {
            currentScore -= 1
        }
        roundCounter += 1
        showingScore = true
    
        if roundCounter > 10 {
            endOfGame = true
        }
    }
    
    func anotherRound() {
        handList.shuffle()
        desiredOutcome = Bool.random()
    }
    
    func reset() {
        roundCounter = 1
        currentScore = 0
        finalScore = 0
        handList.shuffle()
        desiredOutcome = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HandImage: View {
    var handNum: Int
    
    var body: some View {
        if handNum == 0 {
            Image(systemName: "square.fill")
                .font(.largeTitle.weight(.thin))
                .foregroundColor(.red)
        } else if handNum == 1 {
            Image(systemName: "paperplane")
                .font(.largeTitle.weight(.thin))
                .foregroundColor(.red)
        } else if handNum == 2 {
            Image(systemName: "scissors")
                .font(.largeTitle.weight(.thin))
                .foregroundColor(.red)
        }
    }
}

