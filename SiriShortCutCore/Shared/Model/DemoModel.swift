//
//  DemoModel.swift
//  SiriShortCutCore
//
//  Created by 陳邦亢 on 2024/1/2.
//

import Foundation

public struct DemoModel {
    private var object: DemoObject
    
    public var id: Int {
        get { return self.object.id }
        set { self.object.id = newValue }
    }
    
    public var value: String {
        get { return self.object.value }
        set { self.object.value = newValue }
    }
    
    init(id: Int, value: String) {
        self.object = DemoObject(id: id, value: value)
    }
    
    init(obj: DemoObject) {
        self.object = DemoObject(id: obj.id, value: obj.value)
    }
}
