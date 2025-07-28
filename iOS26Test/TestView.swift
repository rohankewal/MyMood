//
//  TestView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 6/17/25.
//

import SwiftUI

struct TestView: View {
    @State var isOn = false
    
    var body: some View {
        VStack {
            if !isOn {
                Button("turn the app on") {
                    isOn.toggle()
                }
            } else {
                Text("The app is on...")
            }
        }
    }
}
