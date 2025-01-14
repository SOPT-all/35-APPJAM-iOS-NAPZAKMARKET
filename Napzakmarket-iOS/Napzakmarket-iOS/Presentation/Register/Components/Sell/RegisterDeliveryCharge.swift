//
//  RegisterDeliveryCharge.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI

struct RegisterDeliveryCharge: View {
    @Binding var deliveryChargeFree: Bool               // 배달비 여부
    @Binding var normalDelivery: Bool                   // 일반 배달비 선택 여부
    @Binding var normalDeliveryCharge: String           // 일반 배달비 금액
    @Binding var halfDelivery: Bool                     // 알뜰,반값 배달비 선택 여부
    @Binding var halfDeliveryCharge: String             // 알뜰,반값 배달비 금액
    
    private let maxDeliveryCharge: Int = 1_000_000      // 최대 금액 100만원

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("배송비")
            
            HStack{
                Button {
                    deliveryChargeFree = true
                } label: {
                    Text("포함")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .background(deliveryChargeFree ? .white : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(deliveryChargeFree ? .black : .gray)
                }
                
                Button {
                    deliveryChargeFree = false
                } label: {
                    Text("별도")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(deliveryChargeFree ? .clear : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(deliveryChargeFree ? .gray : .black)
                }
                
            }
            .padding(3)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if !deliveryChargeFree {
                
                // 일반 택배
                VStack {
                    HStack {
                        Image(systemName:
                                normalDelivery ? "checkmark.square.fill" : "square")
                            .foregroundColor(normalDelivery ? .purple : .gray)
                        
                        Text("일반 택배")
                        
                        Spacer()
                        
                        Image(systemName: normalDelivery ? "chevron.up" : "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        normalDelivery.toggle()
                    }
                    
                    if normalDelivery {
                        VStack {
                            HStack {
                                TextField("0", text: $normalDeliveryCharge)
                                    .onChange(of: normalDeliveryCharge) { oldValue, newValue in
                                        normalDeliveryCharge =
                                        newValue.convertPrice(maxPrice: maxDeliveryCharge)
                                    }
                                
                                Text("원")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 11)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                }
                
                // 알뜰/반값 택배
                VStack {
                    HStack {
                        Image(systemName: halfDelivery ? "checkmark.square.fill" : "square")
                            .foregroundColor(halfDelivery ? .purple : .gray)
                        
                        Text("알뜰/반값 택배")
                        
                        Spacer()
                        
                        Image(systemName: halfDelivery ? "chevron.up" : "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        halfDelivery.toggle()
                    }
                    
                    if halfDelivery {
                        VStack {
                            HStack {
                                TextField("0", text: $halfDeliveryCharge)
                                    .onChange(of: halfDeliveryCharge) { oldValue, newValue in
                                        halfDeliveryCharge =
                                        newValue.convertPrice(maxPrice: maxDeliveryCharge)
                                    }
                                
                                Text("원")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 11)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                }
                
            }
            
        }
        .padding(.horizontal, 20)
    }
}
