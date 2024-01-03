//
//  DemoObject.swift
//  SiriShortCut
//
//  Created by 陳邦亢 on 2024/1/2.
//

import RealmSwift

class DemoObject: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var value: String = ""
    
    convenience init(id: Int, value: String) {
        self.init()
        self.id = id
        self.value = value
    }
}
