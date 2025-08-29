import Combine
import Foundation
import Observation
import SwiftSyntaxMacros

public protocol ObservationType: AnyObject {
    // swiftlint:disable:next identifier_name
    static var _observationReaders: [(Self) -> Void] { get }
    static var observedKeyPaths: [PartialKeyPath<Self>] { get }
}

public extension Observable where Self: ObservationType {
    func changesPublisherUsingReaders() -> AnyPublisher<Void, Never> {
        Deferred { [weak self] () -> AnyPublisher<Void, Never> in
            guard let object = self else { return Empty().eraseToAnyPublisher() }
            let subject = PassthroughSubject<Void, Never>()
            var cancelled = false
            @Sendable func arm(_ obj: Self) {
                if cancelled { return }
                withObservationTracking({
                    type(of: obj)._observationReaders.forEach { $0(obj) }
                }, onChange: {
                    subject.send(())
                    arm(obj)
                })
            }
            arm(object)
            return subject
                .handleEvents(receiveCancel: { cancelled = true })
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

public final class ObservableObjectPublisherHolder {
    public let objectWillChange: ObservableObjectPublisher
    public let anyPublisher: AnyPublisher<Void, Never>
    
    public init(_ anyPublisher: @autoclosure @escaping () -> AnyPublisher<Void, Never>) {
        let observableObjectPublisher = ObservableObjectPublisher()
        self.objectWillChange = observableObjectPublisher
        let any = anyPublisher()
        self.anyPublisher = any
        self.cancellable = any
            .sink { [weak observableObjectPublisher] _ in
                observableObjectPublisher?.send()
            }
    }
    
    deinit {
        cancellable.cancel()
    }
    
    private var cancellable: AnyCancellable
}

@attached(extension, conformances: ObservationType)
@attached(member, names: named(observedKeyPaths), named(_observationReaders), named(objectWillChange), named(_holder))
public macro GenerateObservedKeyPaths() = #externalMacro(
    module: "ObservedKeyPathsMacros",
    type: "GenerateObservedKeyPathsMacro"
)
