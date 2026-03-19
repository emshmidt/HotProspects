//
//  EditView.swift
//  HotProspects
//
//  Created by Эмилия Шмидт on 24.09.2024.
//

import SwiftData
import SwiftUI

struct EditView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var prospect: Prospect
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(prospect.name, text: $prospect.name)
                    .font(.headline)
                
                TextField(prospect.emailAddress, text: $prospect.emailAddress)
                    .font(.headline)
            }
            .navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    init(prospect: Prospect) {
        self.prospect = prospect
    }
}

#Preview {
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect = Prospect(name: "Me", emailAddress: "me@mail.ru", isContacted: false)
        
        return EditView(prospect: prospect)
            .modelContainer(container)
    } catch {
        print("Failed to create container: \(error.localizedDescription)")
        return Text("Hello")
    }
}
