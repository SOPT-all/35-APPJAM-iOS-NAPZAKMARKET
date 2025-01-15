//
//  RegisterSearch.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/14/25.
//

import SwiftUI

struct RegisterSearch: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var text = ""
    @Binding var genre: String
    
    var list: [String] = [
        "산리오",
        "은혼",
        "주술회전",
        "디즈니/픽사",
        "원피스",
        "레고",
        "건담",
        "귀멸의 칼날",
        "나루토",
        "나의 히어로 아카데미아",
        "도쿄 리벤저스",
        "드래곤볼",
        "리락쿠마",
        "마블",
        "명탐정 코난",
        "버추얼",
        "보컬로이드",
        "브라이스",
        "블루아카이브",
        "사카모토 데이즈",
        "슈가슈가룬",
        "스파이 패밀리",
        "슬램덩크",
        "실바니안",
        "앙상블스타즈",
        "에반게리온",
        "원신",
        "지브리 스튜디오",
        "진격의 거인",
        "짱구는 못말려",
        "치이카와",
        "캐릭캐릭체인지",
        "팝마트",
        "페이트",
        "포켓몬스터",
        "프로젝트 세카이",
        "하이큐",
        "헌터x헌터",
        "화산귀환"
    ]
    
    var body: some View {
        VStack{
            Divider()
                .padding(.bottom, 15)
            
            SearchBar(placeholder: "예) 건담, 산리오, 주술회전", text: $text)
                .padding(.horizontal, 20)
            
            List {
                ForEach(list.filter({"\($0)".contains(self.text) || self.text.isEmpty}),
                        id: \.self) { item in
                    HStack{
                        Text(item)
                            .font(.napzakFont(.body5SemiBold14))
                            .applyNapzakTextStyle(napzakFontStyle: .body5SemiBold14)
                            .foregroundStyle(Color.napzakGrayScale(.gray800))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                    }
                    .padding(.vertical, 20)
                    .onTapGesture {
                        genre = item
                        dismiss()
                    }
                }
                .listRowInsets(.init()) // remove insets
                
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 0) // reset default row minimum height
            .padding(.horizontal, 20)

        }
        .navigationTitle("장르")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .foregroundStyle(Color.napzakGrayScale(.gray900))
                    .frame(width: 24, height: 48)
                }
            }
        }


    }
}
