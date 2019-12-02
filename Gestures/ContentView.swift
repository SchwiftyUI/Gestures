//
//  ContentView.swift
//  Gestures
//
//  Created by SchwiftyUI on 12/1/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Single Finger Gestures")) {
                    NavigationLink(destination: Tap()) { Text("Tap Gesture")}
                    NavigationLink(destination: LongPress()) { Text("Long Press Gesture")}
                    NavigationLink(destination: Drag()) { Text("Drag Gesture")}
                }
                Section(header: Text("Multiple Finger Gestures")) {
                    NavigationLink(destination: Rotation()) { Text("Rotation Gesture")}
                    NavigationLink(destination: Magnification()) { Text("Magnification Gesture")}
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
