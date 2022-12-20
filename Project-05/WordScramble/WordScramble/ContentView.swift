//
//  ContentView.swift
//  WordScramble
//
//  Created by Mohamed Jamal Ben Zeglam on 12/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord) //onSubmit means when user presses return
            .onAppear(perform: startGame) //run startGame when loading layout
        }
    }
    func addNewWord() {
        let answer = newWord.lowercased() .trimmingCharacters(in:  .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        //asking swiftUI for Url for our start file on the app
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "SILKWORD"
                return
            }
        }
        //here we will take care of cases of txt file not found or not loading
        fatalError("Could not load start.txt from bundle")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
