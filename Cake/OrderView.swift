//
//  OrderView.swift
//  Cake
//
//  Created by Daichi Morihara on 2021/11/01.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake", selection: $order.type) {
                        ForEach(0..<Order.types.count) { index in
                            Text(Order.types[index])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 1...10) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special request?")
                    }
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                    
                }
                Section {
                    NavigationLink(destination: AddressView()) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cake Corner")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
