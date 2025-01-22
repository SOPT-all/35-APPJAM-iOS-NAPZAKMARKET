//
//  ProductService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

protocol ProductServiceProtocol {
    func putImageToPresignedUrl(
        url: String,
        imageData: Data,
        completion: @escaping (NetworkResult<Void>) -> ()
    )
}

final class ProductService: BaseService, ProductServiceProtocol {
    
    let provider = MoyaProvider<ProductAPI>.init(plugins: [MoyaPlugin()])

    func putImageToPresignedUrl(
        url: String,
        imageData: Data,
        completion: @escaping (NetworkResult<Void>) -> ()
    ) {
        provider.request(.putPresignedURL(url: url, imageData: imageData)) { result in
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    print("이미지 업로드 성공: \(url)")
                    completion(.success(()))
                } else {
                    print("이미지 업로드 실패: \(response.statusCode)")
                    print("무ㅏㅓ가 전달됐길래 이래!!")
                    print("url : \(url)")
                    print("imagedata : \(imageData)")
                }
                
            case .failure(let error):
                print("네트워크 요청 실패: \(error.localizedDescription)")

            }
            print("💡 업로드 작업이 종료되었습니다.") // 종료를 명시적으로 표시

        }
    }

}
