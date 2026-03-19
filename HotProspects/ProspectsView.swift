//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Эмилия Шмидт on 24.09.2024.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    
    let filter: FilterType
    
    enum SortOrder {
        case name, date
    }
    @State private var sortOrder = SortOrder.name
    
    var sortedProspects: [Prospect] {
        switch sortOrder {
        case .name:
            return prospects.sorted { lhs, rhs in
                lhs.name < rhs.name
            }
        case .date:
            return prospects.sorted { lhs, rhs in
                lhs.dateAdded > rhs.dateAdded
            }
            
        }
    }
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            List(sortedProspects, selection: $selectedProspects) { prospect in
                NavigationLink {
                    EditView(prospect: prospect)
                } label: {
                    HStack {
                        if filter == .none {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                                .padding(5)
                                .foregroundStyle(prospect.isContacted ? .green : .gray)
                            
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        
                        Button("Remind me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
                
            }
            .navigationTitle(title)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    EditButton()
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                                    Picker("Sort", selection: $sortOrder) {
                                        Text("Sort by Name")
                                            .tag(SortOrder.name)
                                        Text("Sort by Added Date")
                                            .tag(SortOrder.date)
                                    }
                                }
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete selected", action: delete)
                    }
                }
                
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Milya Shmidt\nshmidt@email.ru", completion: handleScan)
            }
            
            
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        _prospects = Query(sort: [SortDescriptor(\Prospect.name)])
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Пора измерить давление"
            content.subtitle = ""
            content.sound = UNNotificationSound.default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
