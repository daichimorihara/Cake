//
//  OrderView.swift
//  Cake
//
//  Created by Daichi Morihara on 2021/11/01.
//

import SwiftUI


struct OrderView: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.cakeOrder.type) {
                        ForEach(Order.types.indices) { index in
                            Text(Order.types[index])
                        }
                    }
                    Stepper("Number of cakes: \(order.cakeOrder.quantity)", value: $order.cakeOrder.quantity, in: 1...20)
                }
                
                Section {
                    Toggle("Any special request?", isOn: $order.cakeOrder.specialRequestEnabled.animation())
                    
                    if order.cakeOrder.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.cakeOrder.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.cakeOrder.addSprinkles)
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


