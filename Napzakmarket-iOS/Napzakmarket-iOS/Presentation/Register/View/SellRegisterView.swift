//
//  SellRegisterView.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/7/25.
//

import SwiftUI

struct SellRegisterView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var selectedOption = ""
    @State private var price = ""
    
    // 택배비 포함
    @State private var deliveryChargeFree = true
    
    // 일반 택배
    @State private var normalDelivery = false
    @State private var normalDeliveryCharge = ""
    
    // 반값/알뜰 택배
    @State private var halfDelivery = false
    @State private var halfDeliveryCharge = ""
    
    
    // 설명 placeholder
    private let descriptionPlaceholder = "자세히 작성하면 더 빠르고 원활한 거래를 할 수 있어요."
    + "\n예) 출시 연도, 사이즈, 한정판 여부, 네고 여부 등"
    
    // 물건 상태
    private let options = ["미개봉", "아주 좋은 상태", "약간의 사용감", "사용감 있음"]
    
    // 최대 금액 100만원
    private let maxPrice: Int = 1_000_000

    var body: some View {
        NavigationStack {
            RegisterHeaderView()
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // MARK: - 상품 이미지
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("상품 이미지")
                            .font(.system(size: 16))
                        
                        Text("다양한 상품 이미지를 등록하면 판매 확률이 올라가요!")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                        
                        Button {
                            print("버튼 눌림")
                        } label: {
                            VStack(alignment: .center){
                                Image(systemName: "camera")
                                Text("0/10")
                            }
                        }
                        .frame(width: 80, height: 80)
                        .background(.gray)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.top, 12)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - 장르
                    
                    HStack(alignment: .center) {
                        NavigationLink {
                            Text("장르 뷰")
                        } label: {
                            HStack{
                                Text("장르")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - 구분선
                    
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                        .padding(.horizontal, 20)
                    
                    
                    // MARK: - 제목
                    
                    VStack(alignment: .leading) {
                        Text("제목")
                            .padding(.bottom, 12)
                        
                        TextField("제목을 적어주세요.", text: $title)
                            .maxLength(50, text: $title)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 11)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray, lineWidth: 1)
                            }
                        
                        HStack {
                            Spacer()
                            Text("\(title.count) / 50")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                        }
                        .padding(.top, 4)
                        
                    }
                    .padding(.vertical, 35)
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - 설명
                    
                    VStack(alignment: .leading) {
                        Text("설명")
                            .padding(.bottom, 12)
                        
                        ZStack(alignment: .topLeading){
                            TextEditor(text: $description)
                                .maxLength(250, text: $description)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 11)
                            
                            if description.isEmpty {
                                Text(descriptionPlaceholder)
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 19)
                            }
                        }
                        .frame(height: 132)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray, lineWidth: 1)
                        }
                        
                        HStack {
                            Spacer()
                            Text("\(description.count) / 250")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                        }
                        .padding(.top, 4)
                        
                    }
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - 상품 상태
                    
                    VStack(alignment: .leading) {
                        Text("상품 상태")
                            .padding(.bottom, 12)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                            ForEach(options, id: \.self) { option in
                                Button {
                                    selectedOption = option
                                } label: {
                                    Text(option)
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .foregroundColor(selectedOption == option ? .white : .black)
                                        .background(selectedOption == option ? .black : .white)
                                        .clipShape(.rect(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.gray, lineWidth: 1))
                                    
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - 섹션 구분선
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 8)
                        .padding(.vertical, 40)
                    
                    
                    // MARK: - 가격
                    
                    VStack(alignment: .leading) {
                        Text("가격")
                            .padding(.bottom, 12)
                        
                        HStack{
                            TextField("0", text: $price)
                                .onChange(of: price) { oldValue, newValue in
                                    price = stringToPrice(input: newValue)
                                }
                            
                            Text("원")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 11)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray, lineWidth: 1)
                        }
                        
                    }
                    .padding(.bottom, 35)
                    .padding(.horizontal, 20)

                    
                    // MARK: - 배송비
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("배송비")
                        
                        HStack{
                            Button {
                                deliveryChargeFree = true
                            } label: {
                                Text("포함")
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .background(deliveryChargeFree ? .white : .clear)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .foregroundStyle(deliveryChargeFree ? .black : .gray)
                            }
                            
                            Button {
                                deliveryChargeFree = false
                            } label: {
                                Text("별도")
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .background(deliveryChargeFree ? .clear : .white)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .foregroundStyle(deliveryChargeFree ? .gray : .black)
                            }
                            
                        }
                        .padding(3)
                        .background(.gray.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 12))
                        
                        if !deliveryChargeFree {
                            
                            // 일반 택배
                            VStack {
                                HStack {
                                    Image(systemName: normalDelivery ? "checkmark.square.fill" : "square")
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
                                                    normalDeliveryCharge = stringToPrice(input: newValue)
                                                }
                                            
                                            Text("원")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 11)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(.rect(cornerRadius: 10))
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
                                                    halfDeliveryCharge = stringToPrice(input: newValue)
                                                }
                                            
                                            Text("원")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 11)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(.rect(cornerRadius: 10))
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
                .padding(.bottom, 67)
            }
            
            Button(action: {
                print(("tapped button"))
            }, label: {
                Text("등록하기")
            })
            .frame(maxWidth: .infinity, minHeight: 52)
            .foregroundStyle(.white)
            .background(.gray.opacity(1))
            .clipShape(.rect(cornerRadius: 12))
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            
        }
        .scrollIndicators(.hidden)
        
        
    }
    
    
    // MARK: - 3자리마다 쉼표 추가 함수
    private func stringToPrice(input: String) -> String {
        // 숫자만 남기기
        let filteredPrice = input.filter { $0.isNumber }
        guard let price = Int(filteredPrice) else { return "" }
        
        // 최대 금액 제한
        let limitedPrice = min(price, maxPrice)
        
        // 숫자를 3자리마다 쉼표로 구분
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: limitedPrice as NSNumber) ?? ""
    }
    
}

#Preview {
    SellRegisterView()
}
