//
//  ContentView.swift
//  MultiplicationEdutainment
//
//  Created by Mohamed Jamal Ben Zeglam on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    
    //gameOn: true if player is playing, false if player setting up game
    @State private var gameON = false
    //list of all mumbers concidered in the game, may not be needed
    //@State private var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    @State private var firstNumber = 1
    //@State private var secondNumber = 1
    @State private var userAnswer = 0
    //number of queastions player will choose
    @State private var numberOfQuestions = 5
    @State private var questionList: [Question] = []
    @State private var currentScore: Int = 0
    
    @State private var scoreTitle = "" //for post answer alert
    @State private var endOfGameTitle = "Finished👍" //for end of game alert
    @State private var showScore = false //to show post answer alert
    @State private var endOfGame = false //to show end of game alert
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.teal, .pink], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            //use if/else to create a game page and a settings page
            if !gameON {
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
                    //the following modifiers are to change the background color of our form only, otherwise its going to be white
                    .onAppear {
                        UITableView.appearance().backgroundColor = .clear
                    }
                    .onDisappear {
                        UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
                    .background(.yellow)
                    
                    Button("Start the game") {
                        //create an array of questions
                        questionList = createQuestions(table: firstNumber, numOfQuestions: numberOfQuestions)
                        //change to game page
                        gameON.toggle()
                    } .buttonStyle(.borderedProminent)
                }
                .background(.yellow)
            }
            //Now lets construct game page
            else {
                //code for game page
                VStack {
                    Text("Give the correct answer")
                    
                    ForEach(0..<questionList.count, id: \.self) { question in
                        VStack {
                            HStack {
                                Text("\(questionList[question].num1)")
                                Text("X")
                                Text("\(questionList[question].num2)")
                            }
                            
                            TextField("Your Answer", value: $userAnswer, format: .number)
                                .keyboardType(.numberPad)
                            
                            Button("Submit") {
                                if userAnswer == questionList[question].result {
                                    scoreTitle = "Correct"
                                    currentScore += 1
                                } else {
                                    scoreTitle = "Wrong, The correct answer is \(questionList[question].result)"
                                }
                                showScore = true
                            }
                        }
                    }
                }
            }
        }
        .alert(showScore, isPresented: $showScore) {
            Button("Next question")
        }
    }
    
    //this func creates a list of questions in form of an array of Question struct we created below, each instance has 3 numbers, first is the table choosen by user, second is a random number from 1 to 12, third is multiplication of first and second numbers. This func should be called once the user hits play button.
    func createQuestions(table: Int, numOfQuestions: Int) -> [Question] {
        var questions:[Question] = []
        //using stride() instide of 0..<numQuestions since looping in a layout gives error
        for _ in stride(from: 1, through: numOfQuestions, by: 1) {
            let tempQuestion = Question(num1: table, num2: Int.random(in: 1...12))
            questions.append(tempQuestion)
        }
        return questions
    }
}

//create Question struct, to be the file type to store questions and their correct answers
struct Question {
    var num1: Int
    var num2: Int
    var result : Int {
        num1 * num2
    }
    var questionText: String {
        return "\(num1) X \(num2) = \(num1 * num2)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
