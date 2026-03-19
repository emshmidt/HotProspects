//
//  SwiftUIView.swift
//  HotProspects
//
//  Created by Эмилия Шмидт on 21.05.2025.
//

import UserNotifications
import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            Button("Request") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {success, error in
                    if success {
                        print("all set")
                    } else if let error{
                        print(error.localizedDescription)
                    }
                }
            }
            Button ("Scedule") {
                
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
