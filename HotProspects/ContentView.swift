//
//  ContentView.swift
//  HotProspects
//
//  Created by Эмилия Шмидт on 24.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
            
        
    }
}

#Preview {
    ContentView()
}


//working code
//import SwiftUI

//struct ContentView: View {
//var body: some View {
//TabView {
//ProspectsView(filter: .none)
//  .tabItem {
//                    Label("Everyone", systemImage: "person.3")
//              }
//
//          ProspectsView(filter: .contacted)
//              .tabItem {
//                  Label("Contacted", systemImage: //"checkmark.circle")
//          }
//
//          ProspectsView(filter: .uncontacted)
//              .tabItem {
//                  Label("Uncontacted", systemImage: //"questionmark.diamond")
//               }
//
//          MeView()
//              .tabItem {
//                  Label("Me", systemImage: "person.crop.square")
//              }
//      }
//
//
//  }
//}

//#Preview {
//  ContentView()
//}



//end of code





//Select item in List
//struct ContentView: View {
//    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
//    @State private var selection = Set<String>()
//    
//    var body: some View {
//        List(users, id: \.self, selection: $selection) { user in
//            Text(user)
//        }
//        
//        if selection.isEmpty == false {
//            Text("You selected \(selection.formatted())")
//        }
//        
//        EditButton()
//    }
//}


//Simple TabView
//TabView {
//    Text("Tab 1")
//        .tabItem {
//            Label("One", systemImage: "star")
//        }
//    
//    Text("Tab 2")
//        .tabItem {
//            Label("Two", systemImage: "heart")
//        }
//}


//going between tabs *tabView likes to be parent with NavLink inside not the other way around!

//struct ContentView: View {
//    @State private var selectedTab = "One"
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            Button("Show tab 2") {
//                selectedTab = "Two"
//            }
//                .tabItem {
//                    Label("One", systemImage: "star")
//                }
//                .tag("One")
//            
//            Text("Tab 2")
//                .tabItem {
//                    Label("Two", systemImage: "heart")
//                }
//                .tag("Two")
//        }
//    }
//}


//Result type let have error and value in 1 place

//func fetchReadings() async {
//    let fetchTask = Task {
//        let url = URL(string: "https://hws.dev/readings.json")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let readings = try JSONDecoder().decode([Double].self, from: data)
//        return "Found \(readings.count) readings"
//    }
//    
//    let result = await fetchTask.result
//    
//do catch or switch result

//  switch result {
    //case .success(let str):
    //    output = str
    //case .failure(let error):
    //    output = "Error: \(error.localizedDescription)"
    //}
    //
    ////    do {
    ////        output = try result.get()
    ////    } catch {
    ////        output = "Error: \(error.localizedDescription)"
    ////    }
    ////}

//Controling image interpolation *important for line art
//Image(.example)
//    .interpolation(.none)
//    .resizable()


//Context menu

//Text("Change Color")
//    .padding()
////Can't color context menu item
////Use in lots of places
////Short list <3
////Don't repeat actions from other UI
////No important actions (ideally)
//    .contextMenu {
//        Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
//            backgroundColor = .red
//        }
//        
//        Button("Green") {
//            backgroundColor = .green
//        }
//        
//        Button("Blue") {
//            backgroundColor = .blue
//        }
//    }



//SwipeActions *also hidden
//Text("Talor Swift")
//    .swipeActions {
//        Button("Delete", systemImage: "minus.circle", role: .destructive) {
//            print("Delete")
//        }
//    }
//
//    .swipeActions(edge: .leading) {
//        
//        Button("Pin", systemImage: "pin") {
//            print("Pinning")
//        }
//        .tint(.orange)
//    }


//Local notifications

//import UserNotifications

//VStack {
//    Button("Request permission") {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                if success {
//                    print("All set")
//                } else if let error {
//                    print(error.localizedDescription)
//                }
//            }
//    }
//    
//    Button("Schedule notification") {
//        let content = UNMutableNotificationContent()
//        content.title = "Feeed the cat"
//        content.subtitle = "It looks hungry"
//        content.sound = UNNotificationSound.default
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request)
//    }
//}


//Package Dependencies
//xcode -> file -> add package dependency _> search -> add -> import

//import SamplePackage

//let possibleNumbers = Array(1...60)
//var results: String {
//    let selected = possibleNumbers.random(7).sorted()
//    let strings = selected.map(String.init)
//    return strings.formatted()
//}

