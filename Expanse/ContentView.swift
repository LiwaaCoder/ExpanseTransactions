//
//  ContentView.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var  transactionListVm : TranscationListViewModel
   // var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
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
                    let data = transactionListVm.accumlateTransaction()
                    let totalexpanse = data.last?.1 ?? 0
                    CardView{
                        VStack{
                            ChartLabel(totalexpanse.formatted(.currency(code: "USD")),type: .title)
                                                    
                            LineChart()
         
                        }
                            .background(Color.systemBackground)
                    }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.5),Color.icon)))
                        .frame(height: 280)
                      
                    
                    
                    
                    
                    
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
        .accentColor(.primary)
       
    
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
