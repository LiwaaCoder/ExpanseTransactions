//
//  TransctionListViewModel.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import Foundation
import Combine

typealias TranscationGroup = [String : Transaction]

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
        let grouptransaction = TranscationGroup(grouping: transactions){$0.month}
        return grouptransaction
        
    }
}
