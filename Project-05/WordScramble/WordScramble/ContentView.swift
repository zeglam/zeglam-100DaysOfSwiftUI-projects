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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
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
            .alert(errorTitle, isPresented: $showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }
    func addNewWord() {
        let answer = newWord.lowercased() .trimmingCharacters(in:  .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already!", message: "Try a new word.")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word is not possible", message: "Word can not be spelled from \(rootWord).")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can not just make words up.")
            return 
        }
        
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
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
