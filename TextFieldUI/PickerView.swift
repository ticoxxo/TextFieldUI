//
//  PickerView.swift
//  TextFieldUI
//
//  Created by Alberto Almeida on 06/10/23.
//

import SwiftUI

struct PickerView: View {
    @EnvironmentObject var percentVar : PercentTip
    var body: some View {
        VStack {
            Picker("Tip percentage", selection: $percentVar.tipPercentage) {
                ForEach(0..<101) { i in
                    Text(i, format: .percent)
                }
            }
            .pickerStyle(.wheel)
            .padding()
        }
    }
}

#Preview {
    PickerView().environmentObject(PercentTip())
}
