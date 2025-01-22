//
//  ProductService.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import SwiftUI

import Moya

protocol ProductServiceProtocol {
    func getBanners(completion: @escaping (NetworkResult<BannerResponseDTO>) -> ())
    func getPersonalProducts(completion: @escaping (NetworkResult<PersonalProductResponseDTO>) -> ())
    func getPopularSellProducts(completion: @escaping (NetworkResult<PopularSellProductResponseDTO>) -> ())
    func getRecommandedBuyProducts(completion: @escaping (NetworkResult<RecommandedBuyProductResponseDTO>) -> ())
    
    // presigned-url 관련
    func putImageToPresignedUrl(url: String,imageData: Data,completion: @escaping (NetworkResult<Void>) -> ())
    
    // register 관련
    func postRegisterSellRequest(
        registerSellProduct: RegisterSellProductRequestDTO,
        completion: @escaping (NetworkResult<RegisterSellProductResponseDTO>) -> ()
    )
    
    func postRegisterBuyRequest(completion: @escaping (NetworkResult<RegisterBuyProductRequestDTO>) -> ())
    
    
    func getRegisterSellResponse(productId: Int, completion: @escaping (NetworkResult<RegisterSellProductResponseDTO>) -> ())
    
    
    func getRegisterBuyResponse(completion: @escaping (NetworkResult<RegisterBuyProductResponseDTO>) -> ())
    
}

final class ProductService: BaseService, ProductServiceProtocol {
    
    private let provider = MoyaProvider<ProductAPI>.init(plugins: [MoyaPlugin()])
    
    func getBanners(completion: @escaping (NetworkResult<BannerResponseDTO>) -> ()) {
        request(.getBanners, completion: completion)
    }
    
    func getPersonalProducts(completion: @escaping (NetworkResult<PersonalProductResponseDTO>) -> ()) {
        request(.getPersonalProducts, completion: completion)
    }
    
    func getPopularSellProducts(completion: @escaping (NetworkResult<PopularSellProductResponseDTO>) -> ()) {
        request(.getPopularSellProducts, completion: completion)
    }
    
    func getRecommandedBuyProducts(completion: @escaping (NetworkResult<RecommandedBuyProductResponseDTO>) -> ()) {
        request(.getRecommandedBuyProducts, completion: completion)
    }
    
    private func request<T: Decodable>(_ target: ProductAPI, completion: @escaping (NetworkResult<T>) -> ()) {
        provider.request(target) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<T> = self.fetchNetworkResult(
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
    
    func postRegisterSellRequest(registerSellProduct: RegisterSellProductRequestDTO, completion: @escaping (NetworkResult<RegisterSellProductResponseDTO>) -> ()) {
        request(.sellProductRequest(registerItem: registerSellProduct), completion: completion)
    }
    
    
    func getRegisterSellResponse(
        productId: Int,
        completion: @escaping (NetworkResult<RegisterSellProductResponseDTO>) -> ()
    ) {
        provider.request(.sellProductResponse(productId: productId)) { result in
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    do {
                        // 서버의 응답 데이터 파싱
                        let decodedResponse = try JSONDecoder().decode(RegisterSellProductResponseDTO.self, from: response.data)
                        completion(.success(decodedResponse))
                    } catch {
                        print("JSON Parsing Error: \(error.localizedDescription)")
                    }
                } else {
                    print("상품 조회 실패: 상태 코드 \(response.statusCode)")
                }
            case .failure(let error):
                print("상품 조회 네트워크 요청 실패: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    
    func postRegisterBuyRequest(
        completion: @escaping (NetworkResult<RegisterBuyProductRequestDTO>) -> ()
    ) {
        
    }
    
    func getRegisterBuyResponse(completion: @escaping (NetworkResult<RegisterBuyProductResponseDTO>) -> ()) {
        //
    }
    
    
}
