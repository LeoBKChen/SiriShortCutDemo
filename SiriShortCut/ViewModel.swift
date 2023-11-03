//
//  ViewModel.swift
//  SiriShortCut
//
//  Created by 陳邦亢 on 2023/11/3.
//

import Foundation

class ViewModel {
    static let shared = ViewModel()
    
    @Published var labelTest = "Original"
    
    func updateLabel(content: String) {
        self.labelTest = content
    }
}
