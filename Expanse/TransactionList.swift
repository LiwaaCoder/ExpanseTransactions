//
//  TransactionList.swift
//  Expanse
//
//  Created by liwaa on 22/04/2023.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TranscationListViewModel
    var body: some View {
          VStack {
              List {
                  // MARK: Transaction Groups
                  ForEach(Array (transactionListVM.groupTransctionByMonth()), id: \.key) { month,
                      transactions in
                        Section {
                            // MARK: Transaction List
                            ForEach(transactions) { transaction in
                                TransactionRaw(transaction: transaction)
                            }
                        } header: {
                            // MARK: Transaction Month
                            Text (month)
                        }
                        .listSectionSeparator (.hidden)
                      
                  }
              }
              .listStyle (.plain)
          }
          .navigationTitle("Transactions")
          .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM : TranscationListViewModel = {
        let transactionListVM = TranscationListViewModel()
        transactionListVM.transactions =  transactionPreviewlist
        return transactionListVM
        
    }()
    static var previews: some View {
        Group{
                NavigationView{
                    TransactionList()
                }
            
            NavigationView{
                TransactionList()
                    .preferredColorScheme(.dark)
                }
            }
        .environmentObject(transactionListVM)
                
        }
        
}

