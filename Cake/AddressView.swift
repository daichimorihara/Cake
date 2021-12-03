//
//  AdressView.swift
//  Cake
//
//  Created by Daichi Morihara on 2021/11/01.
//

import SwiftUI

struct AddressView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.cakeOrder.name)
                TextField("Street Address", text: $order.cakeOrder.streetAddress)
                TextField("City", text: $order.cakeOrder.city)
                TextField("Zip", text: $order.cakeOrder.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView()
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.cakeOrder.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
 
}
