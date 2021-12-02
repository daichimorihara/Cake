//
//  CakeApp.swift
//  Cake
//
//  Created by Daichi Morihara on 2021/11/01.
//

import SwiftUI

@main
struct CakeApp: App {
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            OrderView()
                .environmentObject(order)
        }
    }
}
