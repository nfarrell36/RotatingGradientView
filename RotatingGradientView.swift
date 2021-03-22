//
//  GradientAnimationsApp.swift
//  GradientAnimations
//
//  Created by Nate Farrell on 3/19/21.
//

import SwiftUI

/**
 Solution based off https://t.co/BPZGJBa7SF?amp=1 article by Pavel Zak
 */
struct RotatingGradientView: View {
    @State private var gradientA: [Color] = [.red, .orange]
    @State private var gradientB: [Color] = [.red, .orange]
    @State private var firstPlane: Bool = true
    @State var colorIndex: Int = 1
    
    let gradients: [[Color]] = [[.orange, .yellow],
                                [.yellow, .green],
                                [.green, .blue],
                                [.blue, .purple],
                                [.red, .orange]]
    
    // Timer in charge of kicking off gradient changes
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    /**
     Depending on which gradient is being shown, the new color is added to the opposite gradient and then flips the firstPlane flag
     */
    func setGradient(gradient: [Color]) {
        if firstPlane {
            gradientB = gradient
        }
        else {
            gradientA = gradient
        }
        firstPlane = !firstPlane
    }

    var body: some View {
        ZStack {
            // Two gradients are used so that the changing of colors in the gradient
            // are animated
            LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: .bottomTrailing, endPoint: .topLeading)

            LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: .bottomTrailing, endPoint: .topLeading)
                .opacity(self.firstPlane ? 0 : 1)
            
            Text("What's up dog?")
                .bold()
        }
        .frame(width: 250, height: 60)
        .animation(.linear(duration: 2.0))
        .cornerRadius(10.0)
        .onReceive(timer) { _ in
            // If colorIndex exceeds the number of gradients, reset back to beginning
            if colorIndex == gradients.count {
                colorIndex = 0
            }
            
            // Set new gradient
            self.setGradient(gradient: gradients[colorIndex])
            
            // Increment color index to move to next gradient
            colorIndex += 1
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RotatingGradientView()
    }
}

