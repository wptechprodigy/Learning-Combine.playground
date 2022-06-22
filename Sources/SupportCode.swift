import Foundation

/// Helper method to write implementations
/// in a clean, easy to understand way

public func example(of description: String,
                    action: () -> Void) {
    print("\n——— Example of:", description, "———")
    action()
}
