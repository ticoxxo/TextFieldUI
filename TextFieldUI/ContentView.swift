//
//  ContentView.swift
//  TextFieldUI
//
//  Created by Alberto Almeida on 04/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 0
    @StateObject var percentVar = PercentTip()
    let tipPercentages = [10, 15, 20, 25, 0]
    @State private var useRedText = false
    
    var totalCheck : Double {
        let tipSelection = Double(percentVar.tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(percentVar.tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    
    @FocusState private var amountIsFocused: Bool
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                /*Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    
                } header: {
                    Text("How much tip would you rather leave, sheep")
                }*/
                
                Section {
                    NavigationLink(destination: PickerView()) {
                        Text(Int(percentVar.tipPercentage) , format: .percent)
                            .foregroundStyle(percentVar.tipPercentage == 0 ? .red : .green)
                    }
                } header: {
                    Text("How much tip will you leave?")
                }
                
                Section {
                    Text(totalCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total amount of the check")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("Split Tab")
        }
        .environmentObject(percentVar)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}

 
#Preview {
    ContentView()
}
