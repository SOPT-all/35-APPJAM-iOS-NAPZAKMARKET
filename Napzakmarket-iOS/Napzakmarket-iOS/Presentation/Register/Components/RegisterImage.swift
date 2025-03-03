//
//  RegisterImage.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/11/25.
//

import SwiftUI
import PhotosUI

struct RegisterImage: View {
    @Binding var selectedImages: [UIImage]
    
    @Binding var imageNameList: [String]
    
    @Binding var presignedUrls: [ProductPresignedUrlsData]
    
    @State private var photosPickerItem: [PhotosPickerItem] = []
    
    private let maxSelectedCount = 10
    
    private var disabled: Bool {
        selectedImages.count >= maxSelectedCount
    }
    
    private var availableSelectedCount: Int {
        maxSelectedCount - selectedImages.count
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleSection
            descriptionSection
            imageScrollSection
        }
        .onChange(of: photosPickerItem) { _ in
            handlePhotoPickerChange()
        }
    }
}

// MARK: - Subviews

extension RegisterImage {
    
    private var titleSection: some View {
        Text("상품 이미지")
            .font(.napzakFont(.body2SemiBold16))
            .applyNapzakTextStyle(napzakFontStyle: .body2SemiBold16)
            .foregroundStyle(Color.napzakGrayScale(.gray900))
    }
    
    private var descriptionSection: some View {
        Text("다양한 상품 이미지를 등록하면 판매 확률이 올라가요!")
            .font(.napzakFont(.body6Medium14))
            .applyNapzakTextStyle(napzakFontStyle: .body6Medium14)
            .foregroundStyle(Color.napzakGrayScale(.gray600))
    }
    
    private var imageScrollSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                photoPickerButton
                
                ForEach(0..<selectedImages.count, id: \.self) { index in
                    imageItemView(for: index)
                }
            }
            .padding(.top, 12)
        }
    }
    
    private var photoPickerButton: some View {
        PhotosPicker(
            selection: $photosPickerItem,
            maxSelectionCount: availableSelectedCount,
            selectionBehavior: .ordered,
            matching: .images
        ) {
            VStack(alignment: .center) {
                Image(.icPhoto)
                
                HStack(spacing: 0) {
                    Text(selectedImages.count.description)
                        .foregroundStyle(selectedImages.count != 0 ? Color.napzakGrayScale(.gray900) : Color.napzakGrayScale(.gray500))
                    Text("/10")
                        .foregroundStyle(Color.napzakGrayScale(.gray500))
                }
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
            }
            .frame(width: 80, height: 80)
            .background(Color.napzakGrayScale(.gray100))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(disabled)
        
    }
    
    private var representativeBadge: some View {
        VStack {
            Spacer()
            
            Text("대표")
                .font(.napzakFont(.caption3Medium12))
                .applyNapzakTextStyle(napzakFontStyle: .caption3Medium12)
                .frame(width: 80)
                .padding(.vertical, 2)
                .background(Color.napzakTransparency(.black70))
                .foregroundStyle(.white)
                .clipShape(
                    .rect(
                        bottomLeadingRadius: 12,
                        bottomTrailingRadius: 12
                    )
                )
        }
    }
    
    
}

// MARK: - Functions

extension RegisterImage {
    
    private func imageItemView(for index: Int) -> some View {
        
        ZStack(alignment: .topLeading) {
            Image(uiImage: selectedImages[index])
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if index == 0 {
                representativeBadge
            }
            
            deleteButton(at: index)
        }
        
    }
    
    private func deleteButton(at index: Int) -> some View {
        VStack{
            HStack{
                Spacer()
                Image(.icXCircleBlack)
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        print("xbutton tapped")
                        selectedImages.remove(at: index)
                        imageNameList.remove(at: index)
                    }
            }
            
            Spacer()
            
            Rectangle()
                .fill(.gray.opacity(0.000000000000000000001))
                .frame(width: 80)
                .frame(maxHeight: .infinity)
                .onLongPressGesture(perform: {
                    print("picture long pressed")
                    moveImageToFront(at: index)
                })
        }
    }
    
    private func handlePhotoPickerChange() {
        Task {
            for item in photosPickerItem {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImages.append(image)
                        imageNameList.append(UUID().uuidString)
                    }
                }
            }
            
            photosPickerItem.removeAll()
        }
    }
    
    private func moveImageToFront(at index: Int) {
        let movedImage = selectedImages.remove(at: index)
        imageNameList.remove(at: index)
        selectedImages.insert(movedImage, at: 0)
        imageNameList.insert(UUID().uuidString, at: 0)
    }
    
}
