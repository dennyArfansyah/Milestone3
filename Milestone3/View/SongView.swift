//
//  SongView.swift
//  Milestone3
//
//  Created by Denny Arfansyah on 06/09/23.
//

import SwiftUI

struct Response: Codable {
    let results: [Result]
}

struct Result: Codable {
    let trackId: Int
    let trackName: String
    let collectionName: String
    let artworkUrl100: String
}

struct SongView: View {
    
    @State private var result = [Result]()
    var body: some View {
        NavigationView {
            List(result, id: \.trackId) { result in
                NavigationLink {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: result.artworkUrl100)!) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                    }
                } label: {
                    VStack(alignment: .leading) {
                        Text(result.trackName)
                            .font(.headline)
                        Text(result.collectionName)
                    }
                }
                .navigationTitle(Constant.song)
            }
        }
        .task {
            await getSong()
        }
    }
    
    func getSong() async {
        guard let url = URL(string: Constant.urlSongs) else {
            print("invalid url")
            return
        }
        
        do {
            let (data, metaData) = try await URLSession.shared.data(from: url)
            guard let metaData = metaData as? HTTPURLResponse, metaData.statusCode == 200 else {
                return
            }
            let decoder = try JSONDecoder().decode(Response.self, from: data)
            result = decoder.results
        } catch {
            print("Invalid data")
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView()
    }
}
