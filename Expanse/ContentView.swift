//
//  ContentView.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            ScrollView
            {
                VStack (alignment: .leading , spacing: 24){
                    //Title
                    Text("OverView")
                        .font(.title3)
                        .bold()
                    
                    // list
                     RecentTranstionList() 
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon,.primary)
                        
                    
                }
            }
            
        }
        .navigationViewStyle(.stack)
       
    
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let transactionListVM : TranscationListViewModel = {
        let transactionListVM = TranscationListViewModel()
        transactionListVM.transactions =  transactionPreviewlist
        return transactionListVM
        
    }()
    static var previews: some View {
        Group{
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
    
}
