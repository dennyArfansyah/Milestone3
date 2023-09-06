//
//  HomeView.swift
//  Milestone3
//
//  Created by Denny Arfansyah on 05/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in 
                    NavigationLink {
                        UserView(user: user)
                    } label: {
                        Text(user.name)
                    }
                }
            }
            .navigationTitle(Constant.title)
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            do {
                users = try await Networking.shared.getFriend()
            } catch UserError.invalidURL {
                print("Invalid URL")
            } catch UserError.invalidResponse {
                print("Invalid Responnse")
            } catch UserError.invalidData {
                print("Invalid Data")
            } catch {
                print("Error")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
