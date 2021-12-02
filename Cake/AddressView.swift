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
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView()
                } label: {
                    Text("Check out")
                }
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct AddressView: View {
//    @ObservedObject var order: Order
//    
//    var body: some View {
//        Form {
//            Section {
//                TextField("Name", text: $order.name)
//                TextField("Street Address", text: $order.streetAddress)
//                TextField("City", text: $order.city)
//                TextField("Zip", text: $order.zip)
//            }
//            
//            Section {
//                NavigationLink(destination: CheckoutView(order: order)) {
//                    Text("Check out")
//                }
//            }
//            .disabled(order.hasValidAddress == false)
//        }
//        .navigationTitle("Delivery details")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}

