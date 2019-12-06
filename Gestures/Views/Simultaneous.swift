//
//  Simultaneous.swift
//  Gestures
//
//  Created by SchwiftyUI on 12/4/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct Simultaneous: View {
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
    
    enum MagnificationState {
        case inactive
        case zooming(scale: CGFloat)
        
        var scale: CGFloat {
            switch self {
            case .zooming(let scale):
                return scale
            default:
                return CGFloat(1.0)
            }
        }
    }
    
    @GestureState var rotationState = RotationState.inactive
    @State var viewRotationState = Angle.zero
    
    @GestureState var magnificationState = MagnificationState.inactive
    @State var viewMagnificationState = CGFloat(1.0)
    
    var magnificationScale: CGFloat {
        return viewMagnificationState * magnificationState.scale
    }
    
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
        
        let magnificationGesture = MagnificationGesture()
            .updating($magnificationState) { value, state, transaction in
                state = .zooming(scale: value)
            }.onEnded { value in
                self.viewMagnificationState *= value
            }
        
        let simultaneous = SimultaneousGesture(rotationGesture, magnificationGesture)
        
        return LogoDrawing()
            .frame(width: 350, height: 650)
            .scaleEffect(magnificationScale)
            .rotationEffect(rotationAngle)
            .gesture(simultaneous)
    }
}

struct Simultaneous_Previews: PreviewProvider {
    static var previews: some View {
        Simultaneous()
    }
}
