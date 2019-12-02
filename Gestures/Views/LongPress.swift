//
//  LongPress.swift
//  Gestures
//
//  Created by SchwiftyUI on 12/1/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct LongPress: View {
    enum LongPressState {
        case inactive
        case pressing
        
        var scale: CGFloat {
            switch self {
            case .pressing:
                return 1.05
            default:
                return 1.0
            }
        }
    }
    
    @GestureState var longPressState = LongPressState.inactive
    @State var tapCount = 0.0
    
    var rotationAngle: Angle {
        return Angle(degrees: 90 * tapCount)
    }
    
    var body: some View {
        
        let longPressGesture = LongPressGesture(minimumDuration: 0.5, maximumDistance: 100)
            .updating($longPressState) { value, state, transaction in
                state = .pressing
        }.onEnded { value in
            withAnimation {
                self.tapCount += 1
            }
        }
        
        return LogoDrawing()
            .frame(width: 350, height: 650)
            .rotationEffect(rotationAngle)
            .scaleEffect(longPressState.scale)
            .gesture(longPressGesture)
    }
}

struct LongPress_Previews: PreviewProvider {
    static var previews: some View {
        LongPress()
    }
}
