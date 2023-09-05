//
//  Networking.swift
//  Milestone3
//
//  Created by Denny Arfansyah on 05/09/23.
//

import SwiftUI

struct Networking {
    
    static let shared = Networking()
    
    func getFriend() async throws -> [User] {
        guard let url = URL(string: Constant.url) else {
            throw UserError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([User].self, from: data)
        } catch {
            throw UserError.invalidData
        }
    }
}
