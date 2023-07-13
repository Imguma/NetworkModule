//
//  ResponseManager.swift
//  NetworkModule
//

import Foundation

public class ResponseManager {
    // data -> dictionary
    public static func convertDataToDictionary(data: Data) -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            return json
        } catch {
            print("coverting error")
        }
        return nil
    }

    // get value with JSON key from dictionary
    public static func getCommonValue(_ responseDictionary: [String: Any]?, key: String, defaultValue: String = "") -> Any {
        if let unwrapping = responseDictionary {
            if let value = unwrapping[key] as? String {
                return value
            }
        }
        return defaultValue
    }
    
    // get value with JSON key from dictionary
    public static func getCommonValue(_ responseDictionary: [String: Any]?, key1: String, key2: String, defaultValue: String = "") -> Any {
        if let unwrapping = responseDictionary {
            if let dic = unwrapping[key1] as? [String: Any] {
                if let value = dic[key2] as? String {
                    return value
                }
            }
        }
        return defaultValue
    }
    
    // get value with JSON key from dictionary
    public static func getCommonValue(_ responseDictionary: [String: Any]?, key1: String, key2: String, key3: String, defaultValue: String = "") -> Any {
        if let unwrapping = responseDictionary {
            if let dic = unwrapping[key1] as? [String: Any] {
                if let innerDic = dic[key2] as? [String: Any] {
                    if let value = innerDic[key3] as? String {
                        return value
                    }
                }
            }
        }
        return defaultValue
    }
}
