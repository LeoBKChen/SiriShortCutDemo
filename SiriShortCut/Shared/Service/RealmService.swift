//
//  RealmService.swift
//  SiriShortCut
//
//  Created by 陳邦亢 on 2024/1/2.
//

import Foundation
import RealmSwift
import Combine

class RealmService {
    static let shared = RealmService()
    
    public class func configRealm() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            // do extra config setting...
        )
    }
    
    func updateDemoData(id: Int, value: String) {
        autoreleasepool {
            let realm = try! Realm()
            
            realm.beginWrite()
            
            let demoObject = DemoObject(
                id: id,
                value: value
            )
            
            realm.add(demoObject, update: .modified)
            
            try! realm.commitWrite()
        }
    }
    
    func subscribeDemoDataChanges() -> Publishers.AssertNoFailure<RealmPublishers.Value<Results<DemoObject>>> {
        let objects = try! Realm().objects(DemoObject.self)
        
        return objects.collectionPublisher
            .assertNoFailure()
    }
}
