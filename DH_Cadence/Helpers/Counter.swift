//
//  Counter.swift
//  DH_Cadence
//
//  Created by David Hou on 2/20/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import Foundation

class Counter {
    var count = 0
    var myTimer: Timer?
    let myInfo = ["name": "David"]
    
    init() {
        // *** 3 ways to implement timer
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            print("One time timer fired \(self.count)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("Queue Timer fired!")
        }
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(repeatedCall), userInfo: myInfo, repeats: true)
    }
    
    deinit {
        myTimer?.invalidate()
        print("deinit Counter")
    }
    
    @objc func repeatedCall (timer: Timer) {
        print("Repeated Call \(self.count) ")
        
        guard let context = timer.userInfo as? [String: String] else {return}
        let user = context["name", default:"unknown"]
        print("user name: \(user)")
        
        count += 1
        if count >= 3 {
            timer.invalidate()
        }
        
    }

}
