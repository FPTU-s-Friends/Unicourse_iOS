//
//  OpenAIService.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 17/6/24.
//

import Alamofire
import Foundation

class OpenAIService {
    private let baseURL = "https://api.openai.com/v1/engines/text-davinci-003/completions"
    private let apiKey = "YOUR_API_KEY" // Replace with your actual OpenAI API key

    typealias CompletionHandler = (Result<String, Error>) -> Void

    func sendMessage(_ message: String, completionHandler: @escaping CompletionHandler) {
        let body = OpenAICompletionsBody(model: "text-davinci-003", prompt: message, temperature: 0.7, max_tokens: 150)

        AF.request(baseURL, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200 ..< 300) // Ensure response status is in the success range
            .responseDecodable(of: OpenAIResponse.self) { response in
                switch response.result {
                case .success(let openAIResponse):
                    if let responseText = openAIResponse.choices.first?.text {
                        completionHandler(.success(responseText))
                    } else {
                        completionHandler(.failure(NSError(domain: "Response parsing error", code: 0, userInfo: nil)))
                    }
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        print("HTTP status code: \(statusCode)")
                    }
                    print("Error sending request to OpenAI API: \(error.localizedDescription)")
                    completionHandler(.failure(error))
                }
            }
    }

    private var headers: HTTPHeaders {
        return [
            "Authorization": "Bearer \(apiKey)"
        ]
    }
}

struct OpenAICompletionsBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Double
    let max_tokens: Int
    let top_p: Double?
    let frequency_penalty: Double?
    let presence_penalty: Double?

    init(model: String, prompt: String, temperature: Double, max_tokens: Int = 100, top_p: Double? = nil, frequency_penalty: Double? = nil, presence_penalty: Double? = nil) {
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.max_tokens = max_tokens
        self.top_p = top_p
        self.frequency_penalty = frequency_penalty
        self.presence_penalty = presence_penalty
    }
}

struct OpenAIResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]

    struct Choice: Decodable {
        let text: String
        let index: Int
        let logprobs: Logprobs?
        let finish_reason: String?
    }

    struct Logprobs: Decodable {
        let tokens: [String]?
        let token_logprobs: [Double]?
        let top_logprobs: [[String: Double]]?
        let text_offset: [Int]?
    }
}
