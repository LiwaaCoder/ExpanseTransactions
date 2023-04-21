//
//  ExpanseApp.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import SwiftUI

@main
struct ExpanseApp: App {
   @StateObject var transactionListVM = TranscationListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
