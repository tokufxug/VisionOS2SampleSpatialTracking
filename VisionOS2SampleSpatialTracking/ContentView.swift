//
//  ContentView.swift
//  VisionOS2SampleSpatialTracking
//
//  Created by Sadao Tokuyama on 7/13/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    var body: some View {
        VStack{
            Text("Hand Tracking with Spatial Tracking")
                .font(.system(size: 72))
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                VStack (spacing: 12) {
                    ToggleImmersiveSpaceButton()
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environment(AppModel())
}
