
import Cache
import Result
import Moya

class CacheManager {

    // MARK: - 读取请求缓存
    static func response(forKey key: String) -> Response? {
        
        do {
            
            let storage = try Storage(diskConfig: DiskConfig(name: "NetResponseCache"),
                        memoryConfig: MemoryConfig(),
                        transformer: Transformer<Response>(
                            toData: { $0.data },
                            fromData: { Response(statusCode: 200, data: $0) }))
            return try storage.object(forKey: key)
        } catch {
            return nil
        }
    }
    
    // MARK: - 缓存请求
    static func setResponse(_ response: Response, forKey: String) {
        
        do {
            
            let storage = try Storage(diskConfig: DiskConfig(name: "NetResponseCache"),
                                      memoryConfig: MemoryConfig(),
                                      transformer: Transformer<Response>(
                                        toData: { $0.data },
                                        fromData: { Response(statusCode: 200, data: $0) }))
            try storage.setObject(response, forKey: forKey)
        } catch {
            print("error\(error)")
        }
    }
    
    // MARK: - 读取模型缓存
    static func object<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
        do {
            
            let storage = try Storage(diskConfig: DiskConfig(name: "NetObjectCache"), memoryConfig: MemoryConfig(), transformer: TransformerFactory.forCodable(ofType: type))
            try storage.removeExpiredObjects()
            return (try storage.object(forKey: key))
        } catch {
            return nil
        }
    }
    
    // MARK: - 缓存模型
    static func setObject<T: Codable>(_ object: T, forKey: String) {
        
        do {
            
            let storage = try Storage(diskConfig: DiskConfig(name: "NetCache"), memoryConfig: MemoryConfig(), transformer: TransformerFactory.forCodable(ofType: T.self))
            try storage.setObject(object, forKey: forKey)
        } catch  {
            print("error\(error)")
        }
    }
}
