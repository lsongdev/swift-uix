import SwiftUI
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

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

#if os(iOS)
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
#elseif os(macOS)
/// NSViewControllerRepresentable for NSSharingServicePicker (Share Sheet)
public struct ShareSheet: NSViewControllerRepresentable {
    let activityItems: [Any]
    
    public init(activityItems: [Any]) {
        self.activityItems = activityItems
    }
    
    public func makeNSViewController(context: Context) -> NSViewController {
        let controller = NSViewController()
        let button = NSButton(frame: NSRect(x: 0, y: 0, width: 100, height: 30))
        button.title = "Share"
        button.bezelStyle = .rounded
        button.target = context.coordinator
        button.action = #selector(Coordinator.showShareSheet(_:))
        controller.view = button
        return controller
    }
    
    public func updateNSViewController(_ nsViewController: NSViewController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject {
        let parent: ShareSheet
        
        init(_ parent: ShareSheet) {
            self.parent = parent
        }
        
        @objc func showShareSheet(_ sender: NSButton) {
            let picker = NSSharingServicePicker(items: parent.activityItems)
            picker.show(relativeTo: .zero, of: sender, preferredEdge: .minY)
        }
    }
}
#endif
