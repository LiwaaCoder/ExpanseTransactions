//
//  TransactionRaw.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import SwiftUI
import SwiftUIFontIcon


struct TransactionRaw: View {
    var transaction : Transaction

    var body: some View {
        HStack(spacing:20)
        {
            RoundedRectangle (cornerRadius: 20 , style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44 , height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon),fontsize: 24,color: Color.icon)
                }
            VStack(alignment: .leading, spacing: 6)
            {
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(transaction.dateParse,format:.dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer( )
            
            Text(transaction.signedAmount , format: .currency(code: "USD "))
                .bold()
                .foregroundColor(transaction.type==TransactionType.credit.rawValue ? Color.text :.primary)
            
        }
        
        .padding([.top , .bottom] , 8)
        
        
        
    }
}

struct TransactionRaw_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRaw(transaction: transactionPreveiwData)
        TransactionRaw(transaction: transactionPreveiwData)
            .preferredColorScheme(.dark )

    }
}
