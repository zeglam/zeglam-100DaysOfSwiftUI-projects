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
    @State private var questionList: [(Int, Int, Int)] = []
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.teal, .pink], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            //use if/else to create game page and settings page
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
                        //create array of questions
                        questionList = createQuestions(table: firstNumber, numOfQuestions: numberOfQuestions)
                        //change to game page
                        gameON.toggle()
                    } .buttonStyle(.borderedProminent)
                }
                .background(.yellow)
            }
            
            else {
                //code for game screen
                VStack {
                    Text("Give the correct answer")
                    
                    HStack {
                        ForEach(questionList, id: \.self) { question in
                            Text("\(firstNumber)")
                            Text("X")
                            Text("\(question.1.content)")
                        }
                    }
                }
            }
        }
        
    }
    
    //this func creates a list of questions in form of an array of tuples, each tuple has 3 numbers, first is the table choosen by user, second is a random number from 1 to 12, third is multiplication of first and second numbers. This func should be called once the user hits play button.
    func createQuestions(table: Int, numOfQuestions: Int) -> () {
        var questions: [(Int, Int, Int)] = []
        for _ in 1...numOfQuestions {
            questions.append((table, Int.random(in: 1...12), table * Int.random(in: 1...12)))
        }
        return questions
    }
}

//create Question struct, to be the file type to store questions and their answers
struct Question {
    var num1: Int
    var num2: Int
    var correctAnswer: Int {
        return num1 * num2
    }
    var questionText: String {
        return "\(num1) X \(num2) = "
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
