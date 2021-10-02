//
//  QiitaAPI.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/10/02.
//

import Foundation
import Moya

enum QiitaAPI {
    case allArticles
    case search(searchWord: String)
}

extension QiitaAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://qiita.com")!
    }
    
    var path: String {
        return "/api/v2/items"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .allArticles:
            return .requestPlain
        case let .search(_: searchWord):
            return .requestParameters(parameters: ["query": searchWord], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
