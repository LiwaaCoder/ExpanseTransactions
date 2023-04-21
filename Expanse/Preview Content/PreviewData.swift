//
//  PreviewData.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import Foundation

var transactionPreveiwData = Transaction(id:1 , date:"04/21/2023",institution: "LiwaaBank" , account: "LiwaaVisa" , merchant: "Apple" , amount: 23.67 , type: "debit" , categoryId: 132 , category: "Software" , isPending: false , isTransfer: false , isExpense: true , isEdited: false )


var transactionPreviewlist = [Transaction](repeating: transactionPreveiwData, count: 8)

