//
//  NetworkResult.swift
//  Napzakmarket-iOS
//
//  Created by 조혜린 on 1/21/25.
//

import Foundation

enum NetworkResult<T> {
    case success(T?)                // 서버 통신 성공했을 때 (200번 대)
    case badRequest                 // 올바르지 않은 요청 에러 발생했을 때 (400)
    case unAuthorized               // 유효하지 않은 JWT 토큰으로 요청했을 때 (401)
    case notFound                   // 존재하지 않는 api를 호출했을 때 (404)
    case internalServerErr          // 서버 내부 오류가 발생했을 때 (500)
    case networkFail                // 네트워크 연결 실패했을 때
    case decodeErr                  // 데이터는 받아왔으나 DTO 형식으로 decode가 되지 않을 때
}
