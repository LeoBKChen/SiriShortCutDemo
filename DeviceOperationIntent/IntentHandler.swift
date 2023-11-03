//
//  IntentHandler.swift
//  DeviceOperationIntent
//
//  Created by 陳邦亢 on 2023/11/3.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is SiriDeviceOperationInfoIntent {
            return SiriDeviceOperationInfoIntentHandler()
        }
        else {
            fatalError("Unhandled Intent error : \(intent)")
        }
        
    }
    
}
