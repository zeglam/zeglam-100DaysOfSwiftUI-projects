//
//  ContentView.swift
//  TimeCnvrt
//
//  Created by Mohamed Jamal Ben Zeglam on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var fromUnit: String = ""
    @State private var toUnit: String = ""
    @State private var inputValue: Double = 0
       
    let units = ["Seconds", "Minutes", "Hours", "Days", "Weeks", "Years"]
    
    @FocusState private var isFocused: Bool
    
    var outputValue: Double {
        
        var valueInSeconds = 0.0
        var result = 0.0
        
        switch fromUnit {
        case "Seconds":
            valueInSeconds = inputValue
        case "Minutes":
            valueInSeconds = inputValue * 60
        case "Hours":
            valueInSeconds = inputValue * 60 * 60
        case "Days":
            valueInSeconds = inputValue * 60 * 60 * 24
        case "Weeks":
            valueInSeconds = inputValue * 60 * 60 * 24 * 7
        case "Years":
            valueInSeconds = inputValue * 60 * 60 * 24 * 7 * 52
        default:
            valueInSeconds = 0
        }
        
        switch toUnit {
        case "Seconds":
            result = valueInSeconds
        case "Minutes":
            result = valueInSeconds / 60
        case "Hours":
            result = valueInSeconds / (60 * 60)
        case "Days":
            result = valueInSeconds / (60 * 60 * 24)
        case "Weeks":
            result = valueInSeconds / (60 * 60 * 24 * 7)
        case "Years":
            result = valueInSeconds / (60 * 60 * 24 * 7 * 52)
        default:
            result = 0
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Convert from: ")
                    
                    Picker("Convert from: ", selection: $fromUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("Convert to: ")
                    
                    Picker("Convert to: ", selection: $toUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("Value to be coverted: ")
                    
                    TextField("Input Value: ", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused)
                } header: {
                    Text("Input Information")
                }
                
                Section {
                    Text(outputValue.formatted(.number.precision(.fractionLength(2))))
                } header: {
                    Text("output Information")
                }
            }
            .navigationTitle("TimeCnvrt")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
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
