//
//  RealmService.swift
//  SiriShortCut
//
//  Created by 陳邦亢 on 2024/1/2.
//

import Foundation
import RealmSwift
import Combine

public class RealmService {
    public static let shared = RealmService()
    
    public class func configRealm() {
        var config = Realm.Configuration(
            // do extra config setting...
        )
        
        let fileManager = FileManager.default
        if let containerURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: AppGroupName.Realm) {
            
            let newRealmURL = containerURL.appendingPathComponent("db.realm")
            
            if let oldRealmURL = config.fileURL,
               fileManager.fileExists(atPath: oldRealmURL.path) {
                // Move the file to the new location
                do {
                    try fileManager.moveItem(at: oldRealmURL, to: newRealmURL)
                    print("Realm file moved successfully")
                } catch {
                    print("Error moving Realm file: \(error.localizedDescription)")
                }
            }
            
            config.fileURL = newRealmURL
        }
        Realm.Configuration.defaultConfiguration = config
    }
    
    public func updateDemoData(id: Int, value: String) {
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
    
    public func subscribeDemoDataChanges() -> AnyPublisher<[DemoModel], Never> {
        let objects = try! Realm().objects(DemoObject.self)
        
        return objects.collectionPublisher
            .map { results in
                results.map { DemoModel(obj: $0) }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    public func getDemoData() -> [DemoModel] {
        let objects = try! Realm().objects(DemoObject.self)
        
        return objects.map {
            DemoModel(obj: $0)
        }
    }

}
