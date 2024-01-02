//
//  ViewController.swift
//  SiriShortCut
//
//  Created by 陳邦亢 on 2023/11/3.
//

import UIKit
import Combine
import Intents
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.donateInteraction()
        // Do any additional setup after loading the view.
        
        ViewModel.shared.$labelTest
            .receive(on: RunLoop.main)
            .sink {
                self.label.text = $0
            }
            .store(in: &self.cancellable)
    }
    
    
    @IBAction func onClickButton(_ sender: Any) {
        RealmService.shared.updateDemoData(id: 1, value: UUID().uuidString)
    }
    
    func donateInteraction(){
        let deviceIntent = SiriDeviceOperationInfoIntent()
        deviceIntent.suggestedInvocationPhrase = "快速操作裝置"
        deviceIntent.deviceName = "裝置名稱"
        deviceIntent.operation = "操作指令"
        let deviceInteraction = INInteraction(intent: deviceIntent, response: nil)
        deviceInteraction.donate {
            (error) in
            if let error = error as NSError? {
                print("device Interaction donation failed: \(error.description)")
            } else {
                print("device Successfully donated interaction")
            }
        }
    }
}

