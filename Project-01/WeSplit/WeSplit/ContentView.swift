//
//  ContentView.swift
//  WeSplit
//
//  Created by Mohamed Jamal Ben Zeglam on 11/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountISFocused: Bool
    //let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount * tipSelection / 100
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalAmount: Double {
        return checkAmount + checkAmount * Double(tipPercentage) / 100
        }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountISFocused)
                
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 50) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Enter check amount and number of people: ")
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("Choose tip percentage: ")
                }
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                        Text("Amount per person: ")
                    }
                Section {
                    Text(totalAmount, format: currencyFormat)
                } header: {
                        Text("Total amount of check: ")
                    }
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountISFocused = false
                    }
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
