
import Cache

class CacheManager {

    // MARK: - 读取缓存
    static func object<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
        do {
            
            let storage = try Storage(diskConfig: DiskConfig(name: "NetCache"), memoryConfig: MemoryConfig(), transformer: TransformerFactory.forCodable(ofType: type))
            try storage.removeExpiredObjects()
            return (try storage.object(forKey: key))
        } catch {
            return nil
        }
    }
    
    // MARK: - 异步存储
    static func setObject<T: Codable>(_ object: T, forKey: String) {
        
        do {
            
            let storage = try Storage(diskConfig: DiskConfig(name: "NetCache"), memoryConfig: MemoryConfig(), transformer: TransformerFactory.forCodable(ofType: T.self))
            try storage.setObject(object, forKey: forKey)
        } catch  {
            print("error\(error)")
        }
    }
}
