import Combine
import Observation
import ObservedKeyPaths
import SwiftUI

// MARK: - Basic Example

@Observable
@GenerateObservedKeyPaths
final class UserProfile {
    var name: String = ""
    var email: String = ""
    var age: Int = 0

    // The macro automatically generates:
    // - observedKeyPaths: [\UserProfile.name, \UserProfile.email, \UserProfile.age]
    // - _observationReaders for efficient tracking
    // - objectWillChange publisher for Combine compatibility
}

// MARK: - Explicit Tracking Example

@Observable
@GenerateObservedKeyPaths
final class Settings {
    var theme: String = "light"
    var fontSize: Int = 14

    var internalId: String = "123" // This won't be tracked

    // Only theme and fontSize will be included in observedKeyPaths
}

// MARK: - Ignoring Properties Example

@Observable
@GenerateObservedKeyPaths
final class DataModel {
    var importantData: String = ""

    @ObservationIgnored var cachedData: String = "" // This won't be tracked
    @ObservationIgnored var debugInfo: String = "" // This won't be tracked
}

// MARK: - Combine Integration Example

@Observable
@GenerateObservedKeyPaths
final class Counter {
    var count: Int = 0

    func increment() {
        count += 1
    }
}

// MARK: - SwiftUI View Example

struct ExampleView: View {
    @State private var userProfile = UserProfile()
    @State private var counter = Counter()

    var body: some View {
        VStack(spacing: 20) {
            Text("User Profile")
                .font(.title)

            TextField("Name", text: $userProfile.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Email", text: $userProfile.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Stepper("Age: \(userProfile.age)", value: $userProfile.age, in: 0...120)

            Divider()

            Text("Counter: \(counter.count)")
                .font(.title2)

            Button("Increment") {
                counter.increment()
            }
            .buttonStyle(.borderedProminent)

            // Example of using the generated observedKeyPaths
            Text("Observed Properties:")
                .font(.caption)
                .foregroundColor(.secondary)

            ForEach(Array(UserProfile.observedKeyPaths.enumerated()), id: \.offset) { _, keyPath in
                Text("• \(String(describing: keyPath))")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .onAppear {
            // Example of Combine integration
            let cancellable = counter.objectWillChange
                .sink { _ in
                    print("Counter changed!")
                }

            // Store cancellable if needed
            _ = cancellable
        }
    }
}

#Preview {
    ExampleView()
}
