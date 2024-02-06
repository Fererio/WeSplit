//
//  ContentView.swift
//  WeSplit
//
//  Created by Balaji Srinivas on 06/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //Calculate the total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var grandTotal: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipAmount
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code:
                        Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                }
                Section {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<101) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
//                        ForEach(0..<101) {
//                            Text($0, format: .percent)
//                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total Amount for the check")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("We Split !")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
