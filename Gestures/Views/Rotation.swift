//
//  Rotation.swift
//  Gestures
//
//  Created by SchwiftyUI on 12/1/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct Rotation: View {
    enum RotationState {
        case inactive
        case rotating(angle: Angle)
        
        var rotationAngle: Angle {
            switch self {
            case .rotating(let angle):
                return angle
            default:
                return Angle.zero
            }
        }
    }
    
    @GestureState var rotationState = RotationState.inactive
    @State var viewRotationState = Angle.zero
    
    var rotationAngle: Angle {
        return viewRotationState + rotationState.rotationAngle
    }
    
    var body: some View {
        
        let rotationGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 5))
            .updating($rotationState) { value, state, transation in
                state = .rotating(angle: value)
        }.onEnded { value in
            self.viewRotationState += value
        }
        
        return LogoDrawing()
            .frame(width: 350, height: 650)
            .rotationEffect(rotationAngle)
            .gesture(rotationGesture)
    }
}

struct Rotation_Previews: PreviewProvider {
    static var previews: some View {
        Rotation()
    }
}
