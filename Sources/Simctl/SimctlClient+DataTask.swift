import Foundation

extension SimctlClient {
  public typealias DataTaskCallback = (Result<Data, SimctlClient.Error>) -> Void
  public typealias DecodedTaskCallback<Value> = (Result<Value, Swift.Error>) -> Void where Value: Decodable
  
  func dataTaskDecoded<Value>(_ route: Route, _ completion: @escaping DecodedTaskCallback<Value>) where Value: Decodable {
    dataTask(route) { result in
      switch result {
      case let .failure(error):
        completion(.failure(error))
        return
        
      case let .success(data):
        do {
          let decoder = JSONDecoder()
          let value: Value = try decoder.decode(Value.self, from: data)
          completion(.success(value))
          return
        } catch {
          completion(.failure(error))
        }
      }
    }
  }
  
  func dataTask(_ route: Route, _ completion: @escaping DataTaskCallback) {
    let task = session.dataTask(with: route.asURLRequest()) { data, urlResponse, error in
      if let error = error {
        completion(.failure(Error.serviceError(error)))
        return
      }
      
      guard let response = urlResponse as? HTTPURLResponse else {
        completion(.failure(Error.noHttpResponse(route)))
        return
      }
      
      guard response.statusCode == 200 else {
        completion(.failure(Error.unexpectedHttpStatusCode(route, response)))
        return
      }
      
      guard let data: Data = data else {
        completion(.failure(Error.noData(route, response)))
        return
      }
      
      completion(.success(data))
    }
    task.resume()
  }
}
