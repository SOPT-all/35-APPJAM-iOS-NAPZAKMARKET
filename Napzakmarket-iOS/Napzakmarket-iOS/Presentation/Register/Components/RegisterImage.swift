//
//  RegisterImage.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI
import PhotosUI

struct RegisterImage: View {
    @State private var images: [UIImage] = []
    @State private var photosPickerItem: [PhotosPickerItem] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("상품 이미지")
                .font(.napzakFont(.body2SemiBold16))
                .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
                .foregroundStyle(Color.napzakGrayScale(.gray900))
            
            Text("다양한 상품 이미지를 등록하면 판매 확률이 올라가요!")
                .font(.napzakFont(.body6Medium14))
                .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
                .foregroundStyle(Color.napzakGrayScale(.gray600))
            
            ScrollView(.horizontal) {
                HStack {
                    // 사진 선택 버튼
                    PhotosPicker(
                        selection: $photosPickerItem,
                        maxSelectionCount: 10-images.count,
                        selectionBehavior: .ordered,
                        matching: .images
                    ) {
                        VStack(alignment: .center){
                            Image(.icPhoto)
                            
                            HStack(spacing: 0) {
                                Text(images.count.description)
                                Text("/10")
                            }
                            .font(.napzakFont(.caption3Medium12))
                            .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                            .foregroundStyle(Color.napzakGrayScale(.gray500))
                        }
                        .frame(width: 80, height: 80)
                        .font(.napzakFont(.caption2SemiBold12))
                        .applyNapzakTextStyle(napzakFontStyle: .caption2SemiBold12)
                        .background(Color.napzakGrayScale(.gray100))
                        .foregroundStyle(Color.napzakGrayScale(.gray500))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    ForEach(0..<images.count, id: \.self) { i in
                        Image(uiImage: images[i])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.top, 12)

            }
            
        }
        .padding(20)
        .onChange(of: photosPickerItem) { _ in
            Task {
                for item in photosPickerItem {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            images.append(image)
                        }
                    }
                }
                
                photosPickerItem.removeAll()
            }
        }
        
    }
}

#Preview {
//    RegisterImage()
    TabBarView()
}
