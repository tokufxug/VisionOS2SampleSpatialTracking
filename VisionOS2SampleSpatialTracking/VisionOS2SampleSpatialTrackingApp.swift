//
//  VisionOS2SampleSpatialTrackingApp.swift
//  VisionOS2SampleSpatialTracking
//
//  Created by Sadao Tokuyama on 7/13/24.
//

import SwiftUI

@main
struct VisionOS2SampleSpatialTrackingApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        .windowStyle(.volumetric)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            SpatialTrackingHandView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
