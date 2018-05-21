
import Cache

class CacheManager {
    
    static let `default` = CacheManager()
    /// Manage storage
    private var storage: Storage?
    // MARK: - init
    init() {

        do {
            storage = try Storage(diskConfig: DiskConfig(name: "NetCache"), memoryConfig: MemoryConfig())
        } catch {
            print(error)
        }
    }

    // MARK: - 读取缓存
    func object<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
        do {
            
            try storage?.removeExpiredObjects()
            return (try storage?.object(ofType: type, forKey: key)) ?? nil
        } catch {
            return nil
        }
    }
    // MARK: - 异步存储
    func setObject<T: Codable>(_ object: T, forKey: String) {
        
        do {
            
            try storage?.setObject(
                object,
                forKey: forKey,
                expiry: nil
            )
        } catch  {
            print(error)
        }
    }
}
