//
//  ViewModel.swift
//  SiriShortCut
//
//  Created by 陳邦亢 on 2023/11/3.
//

import Foundation
import RealmSwift
import Combine

class ViewModel {
    
    static let shared = ViewModel()
    
    @Published var labelTest = "Original"
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.setupBinding()
    }
    
    func setupBinding() {
        let objects = try! Realm().objects(DemoObject.self)
        
        RealmService.shared.subscribeDemoDataChanges()
            .sink { [weak self] in
                
                guard let self = self else { return }
                
                if let object = $0.first {
                    self.labelTest = object.value
                    print(object.value)
                }
            }
            .store(in: &self.cancellable)
    }
    
}
