//
//  UserView.swift
//  Milestone3
//
//  Created by Denny Arfansyah on 05/09/23.
//

import SwiftUI

struct UserView: View {
    let user: User
    var body: some View {
        VStack {
            Text(user.name)
                .font(.largeTitle.bold())
            Text(user.about)
                .font(.caption)
                .padding()
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User.example)
    }
}
