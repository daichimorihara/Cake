//
//  CheckoutView.swift
//  Cake
//
//  Created by Daichi Morihara on 2021/11/01.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var internetConnectionError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cakeOrder.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .alert("Internet Connection Error", isPresented: $internetConnectionError) {
            Button("OK") {}
        } message: {
            Text("You failed to place order.")
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.cakeOrder) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(CakeOrder.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cakes is on its way"
            showingConfirmation = true
        } catch {
            print("Checkout failed")
            internetConnectionError = true
        }
    }
}
