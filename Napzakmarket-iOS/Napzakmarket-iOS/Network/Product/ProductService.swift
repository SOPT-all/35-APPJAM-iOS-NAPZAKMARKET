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
    func putImageToPresignedUrl(
        url: String,
        imageData: Data,
        completion: @escaping (NetworkResult<Void>) -> ()
    )
    func getSellProduct(sortOption: String, genreIDs: [Int]?, isOnSale: Bool, isUnopened: Bool, completion: @escaping (NetworkResult<SellProductResponseDTO>) -> ())
    func getBuyProduct(sortOption: String, genreIDs: [Int]?, isOnSale: Bool, completion: @escaping (NetworkResult<BuyProductResponseDTO>) -> ())
    func getSellProductForSearch(searchWord: String, sortOption: String, genreIDs: [Int]?, isOnSale: Bool, isUnopened: Bool, completion: @escaping (NetworkResult<SellProductResponseDTO>) -> ())
    func getBuyProductForSearch(searchWord: String, sortOption: String, genreIDs: [Int]?, isOnSale: Bool, completion: @escaping (NetworkResult<BuyProductResponseDTO>) -> ())
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
    
    func getSellProduct(sortOption: String, genreIDs: [Int]?, isOnSale: Bool, isUnopened: Bool, completion: @escaping (NetworkResult<SellProductResponseDTO>) -> ()) {
        request(.getSellProduct(sortOption: sortOption, genreIDs: genreIDs, isOnSale: isOnSale, isUnopened: isUnopened), completion: completion)
    }
    
    func getBuyProduct(sortOption: String, genreIDs: [Int]?, isOnSale: Bool, completion: @escaping (NetworkResult<BuyProductResponseDTO>) -> ()) {
        request(.getBuyProduct(sortOption: sortOption, genreIDs: genreIDs, isOnSale: isOnSale), completion: completion)
    }
    
    func getSellProductForSearch(searchWord: String, sortOption: String, genreIDs: [Int]?, isOnSale: Bool, isUnopened: Bool, completion: @escaping (NetworkResult<SellProductResponseDTO>) -> ()) {
        request(.getSellProductForSearch(searchWord: searchWord, sortOption: sortOption, genreIDs: genreIDs, isOnSale: isOnSale, isUnopened: isUnopened), completion: completion)
    }
    
    func getBuyProductForSearch(searchWord: String, sortOption: String, genreIDs: [Int]?, isOnSale: Bool, completion: @escaping (NetworkResult<BuyProductResponseDTO>) -> ()) {
        request(.getBuyProductForSearch(searchWord: searchWord, sortOption: sortOption, genreIDs: genreIDs, isOnSale: isOnSale), completion: completion)
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

}
