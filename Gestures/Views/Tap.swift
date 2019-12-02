//
//  Tap.swift
//  Gestures
//
//  Created by SchwiftyUI on 12/1/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct Tap: View {
    
    @State var tapCount = 0.0
    
    var rotationAngle: Angle {
        return Angle(degrees: 90 * tapCount)
    }
    
    var body: some View {
        
        let tapGesture = TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.tapCount += 1
                }
        }
        
        return LogoDrawing()
            .frame(width: 350, height: 650)
            .rotationEffect(rotationAngle)
            .gesture(tapGesture)
    }
}

struct Tap_Previews: PreviewProvider {
    static var previews: some View {
        Tap()
    }
}
