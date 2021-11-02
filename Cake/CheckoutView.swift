//
//  CheckoutView.swift
//  Cake
//
//  Created by Daichi Morihara on 2021/11/01.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        VStack {
            Text("Your total is $\(order.cost, specifier: "%.2f")")
            Button("Place Order") {
                placeOrder()
            }
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"),
                  message: Text(confirmationMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    private func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reqres.in"
        components.path = "/api/cake"
        let url = components.url!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
            
            
        }
        .resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
