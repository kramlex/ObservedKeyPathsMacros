import Combine
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftUI

public struct GenerateObservedKeyPathsMacro: MemberMacro, ExtensionMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        guard let typeName = typeName(from: decl) else { return [] }
        return [try ExtensionDeclSyntax("extension \(raw: typeName): ObservationType {}")]
    }
    
    public static func expansion(of node: AttributeSyntax, providingMembersOf decl: some DeclGroupSyntax, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        // Определим список «наблюдаемых» свойств
        guard let typeName = typeName(from: decl) else { return [] }
        let props = collectTrackedProperties(in: decl)
        
        // теперь генерируем \TypeName.prop
        let keyPathItems = props.map { name in
            "\\\(typeName).\(name)"
        }.joined(separator: ", ")
        
        let keyPathsDecl: DeclSyntax = """
        static let observedKeyPaths: [PartialKeyPath<\(raw: typeName)>] = [\(raw: keyPathItems)]
        """
        
        let readersItems = props.map { name in
            "{ _ = $0.\(name) as Any }"
        }.joined(separator: ", ")
        
        let readersDecl: DeclSyntax = """
        static let _observationReaders: [(\(raw: typeName)) -> Void] = [\(raw: readersItems)]
        """
        
        let holderDecl: DeclSyntax = """
        @ObservationIgnored
        private lazy var _holder: ObservableObjectPublisherHolder = {
            ObservableObjectPublisherHolder(self.changesPublisherUsingReaders())
        }()
        """
        
        let publisherDecl: DeclSyntax = """
        @ObservationIgnored
        public lazy var objectWillChange: ObservableObjectPublisher = {
            _holder.objectWillChange
        }()
        """
        
        return [keyPathsDecl, readersDecl, holderDecl, publisherDecl]
    }
    
    // MARK: - Helpers
    
    /// Собираем имена свойств:
    /// 1) если есть @ObservationTracked – только они
    /// 2) иначе — все нестатические stored var без @ObservationIgnored
    private static func collectTrackedProperties(in decl: some DeclGroupSyntax) -> [String] {
        var tracked: [String] = []
        var fallback: [String] = []
        
        for member in decl.memberBlock.members {
            guard let varDecl = member.decl.as(VariableDeclSyntax.self) else { continue }
            // только var, не let
            guard varDecl.bindingSpecifier.tokenKind == .keyword(.var) else { continue }
            // без 'static'
            if varDecl.modifiers.contains(where: { $0.name.tokenKind == .keyword(.static) }) == true {
                continue
            }
            
            // берём только простые stored-свойства (один паттерн-идентификатор, без accessor block)
            guard let binding = varDecl.bindings.first,
                  varDecl.bindings.count == 1,
                  binding.accessorBlock == nil,
                  let pattern = binding.pattern.as(IdentifierPatternSyntax.self) else { continue }
            let name = String(pattern.identifier.text)
            
            let attrs = varDecl.attributes.compactMap { attr -> String? in
                // swiftlint:disable:next identifier_name
                if case let .attribute(a) = attr { return a.attributeName.trimmedDescription }
                return nil
            }
            
            let hasTracked = attrs.contains(where: { $0 == "ObservationTracked" || $0 == "_ObservationTracked" })
            let hasIgnored = attrs.contains(where: { $0 == "ObservationIgnored" || $0 == "_ObservationIgnored" })
            
            if hasTracked { 
                tracked.append(name) 
            } else if !hasIgnored { 
                fallback.append(name) 
            }
        }
        
        // если явно помеченных нет — используем «все подходящие»
        return tracked.isEmpty ? fallback : tracked
    }
}

private func typeName(from decl: some DeclGroupSyntax) -> String? {
    let className = decl.as(ClassDeclSyntax.self)?.name.text
    let structName = decl.as(StructDeclSyntax.self)?.name.text
    let actorName = decl.as(ActorDeclSyntax.self)?.name.text
    let enumName = decl.as(EnumDeclSyntax.self)?.name.text
    return className ?? structName ?? actorName ?? enumName
}

@main
struct ObservedKeyPathsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        GenerateObservedKeyPathsMacro.self
    ]
}
