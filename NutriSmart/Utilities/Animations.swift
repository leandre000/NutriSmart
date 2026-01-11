//
//  Animations.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

extension Animation {
    static let friendlySpring = Animation.spring(response: 0.4, dampingFraction: 0.7)
    static let gentleBounce = Animation.spring(response: 0.5, dampingFraction: 0.6)
    static let smoothSlide = Animation.easeInOut(duration: 0.3)
}

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

extension View {
    func shake(times: Int) -> some View {
        modifier(ShakeModifier(shakes: times))
    }
    
    func fadeInScale() -> some View {
        self.modifier(FadeInScaleModifier())
    }
}

struct ShakeModifier: ViewModifier {
    @State private var shakes: CGFloat = 0
    let shakes: Int
    
    func body(content: Content) -> some View {
        content
            .modifier(ShakeEffect(animatableData: shakes))
            .onAppear {
                withAnimation(.default) {
                    self.shakes = CGFloat(shakes)
                }
            }
    }
}

struct FadeInScaleModifier: ViewModifier {
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isVisible ? 1.0 : 0.8)
            .opacity(isVisible ? 1.0 : 0.0)
            .onAppear {
                withAnimation(.friendlySpring) {
                    isVisible = true
                }
            }
    }
}

struct PulseEffect: ViewModifier {
    @State private var isPulsing = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .animation(
                Animation.easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

extension View {
    func pulse() -> some View {
        modifier(PulseEffect())
    }
}


