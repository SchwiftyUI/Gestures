//
//  Sequence.swift
//  Gestures
//
//  Created by SchwiftyUI on 12/4/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct Sequence: View {
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
    
    enum DragState {
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .dragging(let translation):
                return translation
            default:
                return CGSize.zero
            }
        }
    }
    
    @GestureState var dragState = DragState.inactive
    @State var viewDragState = CGSize.zero
    
    @GestureState var longPressState = LongPressState.inactive
    @State var tapCount = 0.0
    
    var rotationAngle: Angle {
        return Angle(degrees: 90 * tapCount)
    }
    
    var translationOffset: CGSize {
        return CGSize(width: viewDragState.width + dragState.translation.width, height: viewDragState.height + dragState.translation.height)
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
                
        let dragGesture = DragGesture(minimumDistance: 10)
            .updating($dragState) { value, state, transaction in
                state = .dragging(translation: value.translation)
            }.onEnded { value in
                self.viewDragState.height += value.translation.height
                self.viewDragState.width += value.translation.width
            }
        
        let sequence = SequenceGesture(longPressGesture, dragGesture)
        
        return LogoDrawing()
            .frame(width: 350, height: 650)
            .rotationEffect(rotationAngle)
            .offset(translationOffset)
            .scaleEffect(longPressState.scale)
            .gesture(sequence)
    }
}

struct Sequence_Previews: PreviewProvider {
    static var previews: some View {
        Sequence()
    }
}
