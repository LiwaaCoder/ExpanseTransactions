//
//  TransctionListViewModel.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import Foundation
import Combine
import Collections

typealias TranscationGroup = OrderedDictionary<String , [Transaction]>
typealias TransactionPrefixSum = [(String , Double)]

final class TranscationListViewModel: ObservableObject
{
    
    @Published var transactions : [Transaction] = [] // sending notiifactions
    
    
    private var cancellable = Set<AnyCancellable>()
    
    init()
    {
        getTransactions()
    }
    
    
    func getTransactions(){
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print ("invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{(data,response)->Data in guard let  httpresponse = response as? HTTPURLResponse , httpresponse.statusCode == 200 else {
                dump(response)
                throw URLError(.badServerResponse)
            }
                return data
        }
            .decode(type: [Transaction].self , decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let Error):
                    print ("Error Fetching " , Error)
                case .finished:
                    print("Finish Fetching")
                }
            } receiveValue: { [weak self] res  in
                self?.transactions = res
            }
            .store(in: &cancellable)
    }
    
    func groupTransctionByMonth()->TranscationGroup{
        
        guard !transactions.isEmpty else{return [:] }
        let grouptransactions = TranscationGroup(grouping: transactions) {$0.month}
        return grouptransactions
        
    }
    
    func accumlateTransaction() ->TransactionPrefixSum{
        print("AccumlateTransactions")
        guard !transactions.isEmpty else {return [] }
        
        let today = "04/22/2023".dateParse()
        let dateInterval = Calendar.current.dateInterval(of:.month, for: today)!
        print ("dateInterval",dateInterval)
        
        var sum : Double = .zero
        var cumlitaveSum = TransactionPrefixSum()
        for date in stride (from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let daily = transactions.filter {$0.dateParse == date && $0.isExpense == true}
            let dailt_total = daily.reduce(0){ $0 - $1.signedAmount}
            sum += dailt_total
            cumlitaveSum.append((date.formatted(),sum))
            print (date.formatted() , "dailtTotal:" , dailt_total , "Sum:" , sum)
    
            }
        return cumlitaveSum
        }
    
}
