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
    
    private let normalMaxDeliveryCharge: Int = 30_000   // 최대 금액 3만원
    private let halfMaxDeliveryCharge: Int = 5_000   // 최대 금액 5000원
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("배송비")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            
            HStack{
                Button {
                    deliveryChargeFree = true
                } label: {
                    Text("포함")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(deliveryChargeFree ? .white : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(
                            deliveryChargeFree ? Color
                                .napzakGrayScale(.gray900) : Color
                                .napzakGrayScale(.gray600)
                        )
                }
                
                Button {
                    deliveryChargeFree = false
                } label: {
                    Text("별도")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(deliveryChargeFree ? .clear : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(
                            deliveryChargeFree ? Color
                                .napzakGrayScale(.gray900) : Color
                                .napzakGrayScale(.gray600)
                        )
                }
                
            }
            .padding(3)
            .background(Color.napzakGrayScale(.gray100))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if !deliveryChargeFree {
                
                // 일반 택배
                VStack {
                    HStack {
                        Image(normalDelivery ? .icCheckboxSelected : .icCheckbox)
                            .onTapGesture {
                                normalDelivery.toggle()
                            }
                        
                        Text("일반 택배")
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakGrayScale(.gray900))
                        
                        Spacer()
                        
                        Image(systemName: normalDelivery ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color.napzakGrayScale(.gray400))
                    }
                    
                    if normalDelivery {
                        HStack {
                            TextField("100~30,000", text: $normalDeliveryCharge)
                                .onChange(of: normalDeliveryCharge) { newValue in
                                    normalDeliveryCharge = newValue
                                        .convertPrice(maxPrice: normalMaxDeliveryCharge)
                                }
                                .foregroundColor(Color.napzakGrayScale(.gray900))
                                .keyboardType(.decimalPad)
                            
                            Text("원")
                                .foregroundColor(Color.napzakGrayScale(.gray600))
                        }
                        .padding(.vertical, 11)
                        .padding(.horizontal, 15)
                        .frame(height: 44)
                        .background(Color.napzakGrayScale(.gray50))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .font(.napzakFont(.body3Medium16))
                        .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                        .padding(.top, 15)
                    }
                    
                }
                .padding(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
                }
                
                // 알뜰/반값 택배
                VStack {
                    HStack {
                        Image(halfDelivery ? .icCheckboxSelected : .icCheckbox)
                            .onTapGesture {
                                halfDelivery.toggle()
                            }
                        
                        Text("알뜰/반값 택배")
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakGrayScale(.gray900))
                        
                        Spacer()
                        
                        Image(systemName: halfDelivery ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color.napzakGrayScale(.gray400))
                    }
                    
                    if halfDelivery {
                        HStack {
                            TextField("0~5,000", text: $halfDeliveryCharge)
                                .onChange(of: halfDeliveryCharge) { newValue in
                                    halfDeliveryCharge = newValue
                                        .convertPrice(maxPrice: halfMaxDeliveryCharge)
                                }
                                .foregroundColor(Color.napzakGrayScale(.gray900))
                                .keyboardType(.decimalPad)
                            
                            Text("원")
                                .foregroundColor(Color.napzakGrayScale(.gray600))
                        }
                        .padding(.vertical, 11)
                        .padding(.horizontal, 15)
                        .frame(height: 44)
                        .background(Color.napzakGrayScale(.gray50))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .font(.napzakFont(.body3Medium16))
                        .applyNapzakTextStyle(napzakFontStyle: .body3Medium16)
                        .padding(.top, 15)
                    }
                    
                }
                .padding(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.napzakGrayScale(.gray200), lineWidth: 1)
                }
                
            }
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    @State var registerType = true
    RegisterView(registerType: $registerType)
}
