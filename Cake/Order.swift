
//
//  Order.swift
//  Cake
//
//  Created by Daichi Morihara on 2021/11/01.
//

import SwiftUI

class Order: ObservableObject {
    @Published var cakeOrder = CakeOrder() {
        didSet {
            saveData()
        }
    }
    
    init() {
        loadData()
    }
    static let types = ["Butter Cake", "Pound Cake", "Sponge Cake", "Angel Food Cake", "Biscuit Cake"]
    
    var userDefaultsKey: String {
        "orderKey"
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decoded = try? JSONDecoder().decode(CakeOrder.self, from: data) {
                cakeOrder = decoded
            }
        }
    }

    func saveData() {
        if let encoded = try? JSONEncoder().encode(cakeOrder) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
}

