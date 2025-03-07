import SwiftUI

/// A view that displays a label and value text in a horizontal stack.
///
/// Use `LabeledText` when you want to display a label-value pair with the label
/// on the left and the value on the right, separated by a spacer.
///
/// Example:
/// ```swift
/// LabeledText(label: "Name", value: "John Doe")
/// ```
public struct LabeledText: View {
    // MARK: - Properties
    
    private let label: String
    private let value: String
    private var labelColor: Color = .primary
    private var valueColor: Color = .primary
    private var labelFont: Font = .body
    private var valueFont: Font = .body
    
    // MARK: - Initializers
    
    /// Creates a new labeled text view with the specified label and value.
    /// - Parameters:
    ///   - label: The label text to display on the left.
    ///   - value: The value text to display on the right.
    public init(label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    /// Creates a new labeled text view with the specified label, value, and value color.
    /// - Parameters:
    ///   - label: The label text to display on the left.
    ///   - value: The value text to display on the right.
    ///   - valueColor: The color to apply to the value text.
    public init(label: String, value: String, valueColor: Color) {
        self.label = label
        self.value = value
        self.valueColor = valueColor
    }
    
    // MARK: - Body
    
    public var body: some View {
        HStack {
            Text(label)
                .foregroundColor(labelColor)
                .font(labelFont)
            Spacer()
            Text(value)
                .foregroundColor(valueColor)
                .font(valueFont)
        }
    }
    
    // MARK: - Modifiers
    
    /// Sets the color of the label text.
    /// - Parameter color: The color to apply to the label text.
    /// - Returns: A modified labeled text view with the specified label color.
    public func labelColor(_ color: Color) -> LabeledText {
        var view = self
        view.labelColor = color
        return view
    }
    
    /// Sets the color of the value text.
    /// - Parameter color: The color to apply to the value text.
    /// - Returns: A modified labeled text view with the specified value color.
    public func valueColor(_ color: Color) -> LabeledText {
        var view = self
        view.valueColor = color
        return view
    }
    
    /// Sets the font of the label text.
    /// - Parameter font: The font to apply to the label text.
    /// - Returns: A modified labeled text view with the specified label font.
    public func labelFont(_ font: Font) -> LabeledText {
        var view = self
        view.labelFont = font
        return view
    }
    
    /// Sets the font of the value text.
    /// - Parameter font: The font to apply to the value text.
    /// - Returns: A modified labeled text view with the specified value font.
    public func valueFont(_ font: Font) -> LabeledText {
        var view = self
        view.valueFont = font
        return view
    }
}

// MARK: - Previews

struct LabeledText_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            LabeledText(label: "Name", value: "John Doe")
            
            LabeledText(label: "Email", value: "john.doe@example.com")
                .labelColor(.secondary)
                .valueColor(.blue)
            
            LabeledText(label: "Status", value: "Active")
                .valueColor(.green)
                .labelFont(.headline)
                .valueFont(.body.bold())
            
            LabeledText(label: "Subscription", value: "Premium")
                .labelFont(.caption)
                .valueFont(.caption)
                .valueColor(.orange)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
