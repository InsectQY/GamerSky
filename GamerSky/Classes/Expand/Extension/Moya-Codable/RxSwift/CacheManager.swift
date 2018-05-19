
import Cache

class CacheManager {
    
    static let `default` = CacheManager()
    /// Manage storage
    private var storage: Storage?
    /// init
    init() {

        do {
            storage = try Storage(diskConfig: DiskConfig(name: "NetCache"), memoryConfig: MemoryConfig())
        } catch {
            print(error)
        }
    }

    /// 读取缓存
    func object<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
        do {
            
            return (try storage?.object(ofType: type, forKey: key)) ?? nil
        } catch {
            return nil
        }
    }
    /// 异步存储
    func setObject<T: Codable>(_ object: T, forKey: String, expiry: Double?) {
        
        do {
            try storage?.setObject(
                object,
                forKey: forKey,
                expiry: .date(Date().addingTimeInterval(expiry ?? 0))
            )
        } catch  {
            print(error)
        }
    }
}
