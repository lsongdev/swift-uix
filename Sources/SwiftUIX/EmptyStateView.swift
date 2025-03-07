import SwiftUI

// MARK: - Empty State View
public struct EmptyStateView: View {
    let title: String
    let systemImage: String
    let description: String
    
    public init(title: String, systemImage: String, description: String) {
        self.title = title
        self.systemImage = systemImage
        self.description = description
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 50))
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

#Preview {
    EmptyStateView(
        title: "No Items",
        systemImage: "tray",
        description: "There are no items to display. Try adding some new items."
    )
}
