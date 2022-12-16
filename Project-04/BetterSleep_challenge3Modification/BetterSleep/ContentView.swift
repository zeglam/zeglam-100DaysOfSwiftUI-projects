//
//  ContentView.swift
//  BetterSleep
//
//  Created by Mohamed Jamal Ben Zeglam on 12/14/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMeassage = ""
    @State private var showAlert = false
    
    static var defultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date.now
    } //static makes prop belongs to struct not instances, so we can use it to calculate other struct props like wakeUp above
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("What is your desired amount of sleep?")
                        .font(.headline)
                }
                
                Section {
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", selection: $coffeeAmount){
                        ForEach(0...20, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How many cups of coffee will you drink today?")
                        .font(.headline)
                }
                
                Section {
                    Text("\(calculateBedTime)")
                        .font(.largeTitle)
                } header: {
                    Text("Recommended time to sleep is")
                        .font(.headline)
                }
            }
            .navigationTitle("Better Rest")
        }
    }
    //for challenge 3, we need to change calculateBedTime from a func to a calculated var, so it can be used inside our layout view
    var calculateBedTime: String {
        let model = try! SleepCalculator(configuration: MLModelConfiguration())
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = 60 * 60 * (components.hour ?? 0)
        let minutes = 60 * (components.minute ?? 0)
        
        var message: String
        do {
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let tempFormatter = DateFormatter()
            tempFormatter.timeStyle = .short
            
            message = tempFormatter.string(from: sleepTime)
        } catch {
            message = "Error"
        }
        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
