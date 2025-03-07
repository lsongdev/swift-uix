import SwiftUI

/// View extension for sharing files
public extension View {
    /// Adds file sharing capability to a view
    /// - Parameters:
    ///   - isPresented: Binding to control the presentation of the share sheet
    ///   - document: Data to be shared
    ///   - filename: Name of the file to be shared
    /// - Returns: A view with file sharing capability
    func shareFile(isPresented: Binding<Bool>, document: Data, filename: String) -> some View {
        self.modifier(FileShareModifier(
            isPresented: isPresented,
            document: document,
            filename: filename
        ))
    }
}

/// View modifier for file sharing
public struct FileShareModifier: ViewModifier {
    @Binding var isPresented: Bool
    let document: Data
    let filename: String
    
    public init(isPresented: Binding<Bool>, document: Data, filename: String) {
        self._isPresented = isPresented
        self.document = document
        self.filename = filename
    }
    
    public func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            ShareSheet(activityItems: [createTemporaryFile()])
                .presentationDetents([.medium, .large])
        }
    }
    
    /// Creates a temporary file for sharing
    /// - Returns: URL of the temporary file
    private func createTemporaryFile() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(filename)
        do {
            try document.write(to: fileURL)
            return fileURL
        } catch {
            print("Failed to create temporary file: \(error.localizedDescription)")
            return fileURL
        }
    }
}

/// UIViewControllerRepresentable for UIActivityViewController (Share Sheet)
public struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    public init(activityItems: [Any]) {
        self.activityItems = activityItems
    }
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
