import Foundation
import RxSwift
import RxCocoa

extension ObservableType where E == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}

public extension Driver {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<S, E> {
        return map {
            closure()
            return $0
        }
    }
}

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<E> {

        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<E> {
        return map {
            try closure()
            return $0
        }
    }
}


