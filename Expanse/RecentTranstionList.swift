//
//  RecentTranstionList.swift
//  Expanse
//
//  Created by liwaa on 22/04/2023.
//

import SwiftUI

struct RecentTranstionList: View {
    @EnvironmentObject var transactionListVM:TranscationListViewModel
    var body: some View {
        
        VStack{
            HStack{
                Text("Recenet Transcation")
                    .bold()
                
                Spacer()
                
                NavigationLink{
                    TransactionList()
                    
                } label: {
                    HStack(spacing: 4){
                        Text("See All Transction")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
                
                               
            }.padding(.top)
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()),id :\.element)
            {
               index , transaction in  TransactionRaw(transaction:transaction)
                Divider().opacity(index == 4 ?  0 : 1)
            }
            
        }.padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20 , style: .continuous))
            .shadow(color: .primary.opacity(2.5), radius: 12 , x:0 , y:5 )
        
    }
}

struct RecentTranstionList_Previews: PreviewProvider {
    static let transactionListVM : TranscationListViewModel = {
        let transactionListVM = TranscationListViewModel()
        transactionListVM.transactions =  transactionPreviewlist
        return transactionListVM
        
    }()
     
    static var previews: some View {
        Group{
            RecentTranstionList()
            RecentTranstionList()
                .preferredColorScheme(.dark)

        }
        .environmentObject(transactionListVM )
    }
}
