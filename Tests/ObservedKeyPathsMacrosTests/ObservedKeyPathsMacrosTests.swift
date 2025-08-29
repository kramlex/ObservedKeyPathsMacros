import ObservedKeyPathsMacros
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class ObservedKeyPathsMacrosTests: XCTestCase {
    
    let testMacros: [String: Macro.Type] = [
        "GenerateObservedKeyPaths": GenerateObservedKeyPathsMacro.self
    ]
    
    func testBasicMacroExpansion() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            class TestClass {
                var name: String = ""
                var age: Int = 0
            }
            """,
            expandedSource: """
            @Observable
            class TestClass {
                var name: String = ""
                var age: Int = 0

                static let observedKeyPaths: [PartialKeyPath<TestClass>] = [\\TestClass.name, \\TestClass.age]

                static let _observationReaders: [(TestClass) -> Void] = [{
                        _ = $0.name as Any
                    }, {
                        _ = $0.age as Any
                    }]

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension TestClass: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithObservationTracked() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            class TestClass {
                @ObservationTracked var tracked: String = ""
                var ignored: Int = 0
            }
            """,
            expandedSource: """
            @Observable
            class TestClass {
                @ObservationTracked var tracked: String = ""
                var ignored: Int = 0

                static let observedKeyPaths: [PartialKeyPath<TestClass>] = [\\TestClass.tracked]

                static let _observationReaders: [(TestClass) -> Void] = [{
                        _ = $0.tracked as Any
                    }]

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension TestClass: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithObservationIgnored() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            class TestClass {
                var tracked: String = ""
                @ObservationIgnored var ignored: Int = 0
            }
            """,
            expandedSource: """
            @Observable
            class TestClass {
                var tracked: String = ""
                @ObservationIgnored var ignored: Int = 0

                static let observedKeyPaths: [PartialKeyPath<TestClass>] = [\\TestClass.tracked]

                static let _observationReaders: [(TestClass) -> Void] = [{
                        _ = $0.tracked as Any
                    }]

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension TestClass: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithStaticProperties() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            class TestClass {
                static var staticProperty: String = ""
                var instanceProperty: Int = 0
            }
            """,
            expandedSource: """
            @Observable
            class TestClass {
                static var staticProperty: String = ""
                var instanceProperty: Int = 0

                static let observedKeyPaths: [PartialKeyPath<TestClass>] = [\\TestClass.instanceProperty]

                static let _observationReaders: [(TestClass) -> Void] = [{
                        _ = $0.instanceProperty as Any
                    }]

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension TestClass: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithComputedProperties() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            class TestClass {
                var stored: String = ""
                var computed: Int {
                    return stored.count
                }
            }
            """,
            expandedSource: """
            @Observable
            class TestClass {
                var stored: String = ""
                var computed: Int {
                    return stored.count
                }

                static let observedKeyPaths: [PartialKeyPath<TestClass>] = [\\TestClass.stored]

                static let _observationReaders: [(TestClass) -> Void] = [{
                        _ = $0.stored as Any
                    }]

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension TestClass: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithStruct() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            struct TestStruct {
                var name: String = ""
                var value: Int = 0
            }
            """,
            expandedSource: """
            @Observable
            struct TestStruct {
                var name: String = ""
                var value: Int = 0

                static let observedKeyPaths: [PartialKeyPath<TestStruct>] = [\\TestStruct.name, \\TestStruct.value]

                static let _observationReaders: [(TestStruct) -> Void] = [{
                        _ = $0.name as Any
                    }, {
                        _ = $0.value as Any
                    }]

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension TestStruct: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithActor() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            actor TestActor {
                var name: String = ""
                var value: Int = 0
            }
            """,
            expandedSource: """
            @Observable
            actor TestActor {
                var name: String = ""
                var value: Int = 0

                static let observedKeyPaths: [PartialKeyPath<TestActor>] = [\\TestActor.name, \\TestActor.value]

                static let _observationReaders: [(TestActor) -> Void] = [{
                        _ = $0.name as Any
                    }, {
                        _ = $0.value as Any
                    }]

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension TestActor: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithEmptyClass() throws {
        assertMacroExpansion(
            """
            @Observable
            @GenerateObservedKeyPaths
            class EmptyClass {
            }
            """,
            expandedSource: """
            @Observable
            class EmptyClass {

                static let observedKeyPaths: [PartialKeyPath<EmptyClass>] = []

                static let _observationReaders: [(EmptyClass) -> Void] = []

                @ObservationIgnored
                private lazy var _holder: ObservableObjectPublisherHolder = {
                    ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
                }()

                @ObservationIgnored
                public lazy var objectWillChange: ObservableObjectPublisher = {
                    _holder.objectWillChange
                }()
            }

            extension EmptyClass: ObservationType {
            }
            """,
            macros: testMacros
        )
    }
}
