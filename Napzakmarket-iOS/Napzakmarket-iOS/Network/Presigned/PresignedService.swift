//
//  PresignedService.swift
//  Napzakmarket-iOS
//
//  Created by OneTen on 1/22/25.
//

import SwiftUI

import Moya

protocol PresignedServiceProtocol {
    // presigned-url 관련
    func getPresignedURL(imageNameList: [String], completion: @escaping (NetworkResult<PresignedResponseDTO>) -> ())
    
    func putImageToPresignedUrl(url: String, imageData: Data,completion: @escaping (NetworkResult<Void>) -> ())
    }

final class PresignedService: BaseService, PresignedServiceProtocol {
    
    let provider = MoyaProvider<PresignedAPI>.init(plugins: [MoyaPlugin()])

    func getPresignedURL(imageNameList: [String], completion: @escaping (NetworkResult<PresignedResponseDTO>) -> ()) {
        provider.request(.getPresignedURL(imageNameList: imageNameList)) { result in
            switch result {
            case .success(let response):
                
                let networkResult: NetworkResult<PresignedResponseDTO> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )
                
                completion(networkResult)

            case .failure(let err):
                print(err)
            }
        }
    }
    
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
                }
                
            case .failure(let error):
                print("네트워크 요청 실패: \(error.localizedDescription)")
                
            }
            print("💡 업로드 작업이 종료되었습니다.") // 종료를 명시적으로 표시
            
        }
    }
    
    
}
