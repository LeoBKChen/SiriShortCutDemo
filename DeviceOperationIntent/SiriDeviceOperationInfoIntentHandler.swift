//
//  SiriDeviceOperationInfoIntentHandler.swift
//  DeviceIntent
//
//  Created by 陳邦亢 on 2023/10/20.
//

import Foundation
import Intents
import SiriShortCutCore

class SiriDeviceOperationInfoIntentHandler: NSObject, SiriDeviceOperationInfoIntentHandling {
    
    func handle(intent: SiriDeviceOperationInfoIntent, completion: @escaping (SiriDeviceOperationInfoIntentResponse) -> Void) {

        guard let deviceName = intent.deviceName,
              let operation = intent.operation
        else {
            completion(SiriDeviceOperationInfoIntentResponse(code: .failure, userActivity: nil))
            return
        }

        RealmService.configRealm()
        
        let originalRealmValue = RealmService.shared.getDemoData().first?.value ?? "nil"
        let newValue = "\(deviceName) \(operation)"
        RealmService.shared.updateDemoData(id: 1, value: newValue)
        
        completion(.success(result: "將\(originalRealmValue)改為\(newValue)"))
    }
    
    // result type: https://developer.apple.com/documentation/sirikit/resolving_and_handling_intents/resolving_the_parameters_of_an_intent#2864163
    func resolveDeviceName(for intent: SiriDeviceOperationInfoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let deviceName = intent.deviceName,
           deviceName.count > 0,
           deviceName != "裝置名稱"{
            completion(INStringResolutionResult.success(with: deviceName))
        }
        else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    
    func resolveOperation(for intent: SiriDeviceOperationInfoIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let operation = intent.operation,
           operation.count > 0,
           operation != "操作指令" {
            completion(INStringResolutionResult.success(with: operation))
        }
        else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    
}
