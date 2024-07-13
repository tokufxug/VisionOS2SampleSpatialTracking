//
//  SpatialTrackingHandView.swift
//  VisionOS2SampleSpatialTracking
//
//  Created by Sadao Tokuyama on 7/13/24.
//

import SwiftUI
import RealityKit
import ARKit

struct SpatialTrackingHandView: View {
    
    let handJoints: Array<AnchoringComponent.Target.HandLocation.HandJoint> = [
        .forearmArm,
        //.forearmWrist,
        .indexFingerIntermediateBase,
        .indexFingerTip,
        .indexFingerKnuckle,
        .indexFingerMetacarpal,
        .indexFingerIntermediateTip,
        .littleFingerIntermediateBase,
        .littleFingerTip,
        .littleFingerKnuckle,
        .littleFingerMetacarpal,
        .littleFingerIntermediateTip,
        .middleFingerIntermediateBase,
        .middleFingerTip,
        .middleFingerKnuckle,
        .middleFingerMetacarpal,
        .middleFingerIntermediateTip,
        .ringFingerIntermediateBase,
        .ringFingerTip,
        .ringFingerKnuckle,
        .ringFingerMetacarpal,
        .ringFingerIntermediateTip,
        //.thumbIntermediateBase,
        //.thumbKnuckle,
        .thumbIntermediateTip,
        .thumbTip,
        .wrist
    ]
    var body: some View {
        RealityView { content in
            if let entity = try? await Entity(named: "toy_drummer_idle") {
                entity.scale*=0.25
                let session = SpatialTrackingSession()
                let configuration = SpatialTrackingSession.Configuration(tracking: [.hand])
                let unapprovedCapabilities = await session.run(configuration)
                
                if let unapprovedCapabilities, unapprovedCapabilities.anchor.contains(.hand) {
                    print("User has rejected hand data for your app.")
                } else {
                    for chirality in [AnchoringComponent.Target.Chirality.left, .right] {
                        for handjoint in handJoints {
                            let copyEntity = entity.clone(recursive: true)
                            let count = copyEntity.availableAnimations.count
                            if count > 0 {
                                copyEntity.playAnimation(copyEntity.availableAnimations[count - 1].repeat())
                            }
                            
                            if handjoint == .wrist || handjoint == .forearmArm || handjoint == .forearmWrist {
                                copyEntity.scale*=5.0
                            }
                            copyEntity.position.y+=0.015
                            let joint = AnchoringComponent.Target.HandLocation.joint(for: handjoint)
                            let location = AnchorEntity(.hand(chirality, location: joint), trackingMode: .predicted)
                            content.add(location)
                            location.addChild(copyEntity)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SpatialTrackingHandView()
}
