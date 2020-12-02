//
//  TVClient.swift
//  TVManager
//
//  Created by Emad Albarnawi on 04/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation
import Alamofire;

typealias type = HorizantalCollectionViewDataSource.HorizantalCollectionViewType;
class TVClient {
    public static let shared = TVClient();
    
    private init() {}
    
    static var hasSessionID: Bool = false;
    struct Auth {
        static fileprivate let APIKey: String = "?api_key=1b2cb3475b2de18edda91152974690ca";
        static fileprivate var token: String = "";
        static fileprivate var sessionID: String = "";
        static fileprivate var accountID: String = "";
        
        static func SetSessionID(id: String){
            Auth.sessionID = id;
        }
        static func setAccountID(id: String){
            Auth.accountID = id;
        }
        
    }
    static private let baseURL: String = "https://api.themoviedb.org/3/";
    static private let imageBaseURL: String = "https://image.tmdb.org/t/p/";
    enum ImageEndPoints {
        case getImageWith(size: String? = "w500", path: String);
        case getOriginalImage(path: String);
//        case getw500Image(path: String)
        
        var stringValue: String {
            switch self {
            case .getImageWith(let size, let path):
                return "\(TVClient.imageBaseURL)\(size!)\(path)";
            case .getOriginalImage(let path):
                return "\(TVClient.imageBaseURL)original\(path)";
            }
        }
    }
    
    static private var parmas: [String: String] = [:];
    
    static private var decoder:JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase;
        decoder.dateDecodingStrategy = .iso8601;
        
        return decoder
    }
    static let defaults = UserDefaults.standard;
        
    
    
    enum EndPoints {
        enum Kind {
            case tv, movie;
        }
        
        case auth;
        case loginAuth;
        case getSessionID;
        case searchKeyWords(query: String);
        case searchMovie(query: String);
        
        case multiSearch(query: String);
        
        case account;
        case getCreatedLists(accountID: String);
        case getFavorite(Kind);
        case getWatchlist(Kind);
        
        case postFavorite;
        case postWatchlist;
        
        case getPopular(Kind);
        
        
        var stringURL: URL {
            switch self {
            case .auth:
                return URL(string: "\(TVClient.baseURL)authentication/token/new\(TVClient.Auth.APIKey)")!;
            case .loginAuth:
                return URL(string: "\(TVClient.baseURL)authentication/token/validate_with_login\(TVClient.Auth.APIKey)")!;
            case .getSessionID:
                return URL(string: "\(TVClient.baseURL)authentication/session/new\(TVClient.Auth.APIKey)")!;
            case .getPopular(let popularKind):
                switch popularKind {
                case .tv:
                    return URL(string: "\(TVClient.baseURL)\(popularKind)/popular\(TVClient.Auth.APIKey)")!
                case .movie:
                    return URL(string: "\(TVClient.baseURL)\(popularKind)/popular\(TVClient.Auth.APIKey)")!
                }
            case .searchKeyWords(let query):
                return URL(string: "\(TVClient.baseURL)search/keyword\(TVClient.Auth.APIKey)&query=\(query)")!
            case .searchMovie(let query):
                return URL(string: "\(TVClient.baseURL)search/movie\(TVClient.Auth.APIKey)&query=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!
            case .multiSearch(let query):
                return URL(string: "\(TVClient.baseURL)search/multi\(TVClient.Auth.APIKey)&query=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!
            case .account:
                return URL(string: "\(TVClient.baseURL)account\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
            case .getCreatedLists(let accountID):
                return URL(string: "\(TVClient.baseURL)account/\(accountID)/lists\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
            case .getFavorite(let kind):
                switch kind {
                case .tv:
                    return URL(string: "\(TVClient.baseURL)account/\(Auth.accountID)/favorite/tv\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
                case .movie:
                    return URL(string: "\(TVClient.baseURL)account/\(Auth.accountID)/favorite/movies\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
                    
                }
            case .getWatchlist(let kind):
                switch kind {
                case .tv:
                    return URL(string: "\(TVClient.baseURL)account/\(Auth.accountID)/watchlist/tv\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
                case .movie:
                    return URL(string: "\(TVClient.baseURL)account/\(Auth.accountID)/watchlist/movies\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
                    
                }
            case .postFavorite:
                return URL(string: "\(TVClient.baseURL)account/\(Auth.accountID)/favorite\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
            case .postWatchlist:
                return URL(string: "\(TVClient.baseURL)account/\(Auth.accountID)/watchlist\(TVClient.Auth.APIKey)&session_id=\(TVClient.Auth.sessionID)")!
            }
        }
    }

    
    func authUsers() {
        let url = TVClient.EndPoints.auth.stringURL;
        
        AF.request(url, parameters: TVClient.parmas).responseJSON { (response) in
//            print(response);
            guard let data = response.data else { return }
            do {
                let result = try TVClient.decoder.decode(TokenResponse.self, from: data);
//                print(result.requestToken);
                TVClient.Auth.token = result.requestToken;
            } catch {
                fatalError();
            }
        }
        
        
    }
    func askForPermission() {
        let url = URL(string: "https://www.themoviedb.org/authenticate/\(TVClient.Auth.token)?redirect_to=TVManager://");
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:]) { (success) in
//                print(success);
                if success {
//                    TVClient.shared.getSessionID();
                }
            }
        }
    }
    func authWith(username: String, password: String, compleation: @escaping (Bool, Error?) -> Void) {
        let url = TVClient.EndPoints.loginAuth.stringURL;
        TVClient.parmas["username"] = username;
        TVClient.parmas["password"] = password;
        TVClient.parmas["request_token"] = TVClient.Auth.token;
//        print(TVClient.parmas)
//        = [username: username, password: password, request_token: TVClient.token];
        AF.request(url, method: .post, parameters: TVClient.parmas, encoding: JSONEncoding.default).responseJSON { (resopnse) in
            switch resopnse.result {
            case .success:
//                TVClient.shared.askForPermission();
                TVClient.shared.getSessionID { (success, error) in
                    if success {
                        compleation(true, nil);
                    }
                }
                break;
            case .failure:
//                debugPrint(resopnse)
                compleation(false, resopnse.error);
                break;
            }

        }
    }
    
    
    func getSessionID(compleation: @escaping (Bool, Error?) -> Void) {
        let url = TVClient.EndPoints.getSessionID.stringURL;
        let params = ["request_token": "\(TVClient.Auth.token)"];
        AF.request(url, method: .post, parameters: params).responseJSON { (response) in
            // TODO: Handel error, IF user clickes denay on the websit or any other reason
            guard let data = response.data else { return }
            do {
                let result = try TVClient.decoder.decode(SessionResponse.self, from: data);
                TVClient.Auth.sessionID = result.sessionId;
                TVClient.hasSessionID = true;
                TVClient.defaults.set(true, forKey: "hasSessionID")
                TVClient.defaults.set("\(result.sessionId)", forKey: "sessionID");
                compleation(true, nil);
            } catch {
                fatalError("Error getting session ID");
            }
        }
    }
    
    func PostDecodableRequest(kind: EndPoints.Kind, mediaID: Int, listType: HorizantalCollectionViewCell.ListType, compleation: @escaping (Bool, Error?) -> Void) {
        var url: URL
        switch listType {
        case .favorite:
            url = TVClient.EndPoints.postFavorite.stringURL;
        case .watchlist:
            url = TVClient.EndPoints.postWatchlist.stringURL;
        }
        
        let params = ["media_type": "\(kind)", "media_id": mediaID, listType.rawValue: true] as [String : Any];
        print("URL", url, "params", params);
        AF.request(url, method: .post, parameters: params).responseJSON { (response) in
            // TODO: Ceck the Docs and make the response model
            guard let data = response.data else { return }
            do {
                let result = try TVClient.decoder.decode(FeedbackResponse.self, from: data);
                compleation(true, nil);
            } catch {
                fatalError("Error getting session ID");
            }
        }
        
        
        
    }
    
    func getDecodableRequest<Response: Decodable>(url: URL, response: Response.Type,completion: @escaping ((Response?, Error?) -> Void)) {
        
        AF.request(url).responseDecodable(of: response, decoder: TVClient.decoder) { (response) in
//            debugPrint(response);
            switch response.result {
            case .success(let result):
//                print(result);
                completion(result, nil);
            case .failure(let error):
                print(error);
                completion(nil, error)
            }
        }
    }
    func getDecodableRequest<Response: Decodable>(url: URL, kind: HomeViewController.Kind, response: Response.Type,completion: @escaping ((Response?, HomeViewController.Kind, Error?) -> Void)) {
        print(url);
        AF.request(url).responseDecodable(of: response, decoder: TVClient.decoder) { (response) in
//            debugPrint(response);
            switch response.result {
            case .success(let result):
//                print(result);
                completion(result, kind, nil);
            case .failure(let error):
                print(error);
                completion(nil, kind, error)
            }
        }
    }
    
    func downloadeHomeImages(path: String, Kind: HomeViewController.Kind, completion: @escaping (UIImage?, Error?, HomeViewController.Kind) -> Void) {
        print(path);
        let url = TVClient.ImageEndPoints.getImageWith(path: path).stringValue;
        print(url);
        AF.request(url).response { (response) in
            guard let data = response.data else { return }
            let image = UIImage(data: data);
            DispatchQueue.main.async {
                completion(image, nil, Kind);
            }
        }
    }
    func downloadeImages(path: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let url = TVClient.ImageEndPoints.getImageWith(path: path).stringValue;
        AF.request(url).response { (response) in
            guard let data = response.data else { return }
            let image = UIImage(data: data);
            DispatchQueue.main.async {
                completion(image, nil);
            }
        }
    }
    
}
