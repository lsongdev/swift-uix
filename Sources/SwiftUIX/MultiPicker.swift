import SwiftUI

// Environment key for selection binding
private struct MultiPickerSelectionKey<SelectionValue: Hashable>: EnvironmentKey {
    static var defaultValue: Binding<Set<SelectionValue>>? { nil }
}

extension EnvironmentValues {
    var multiPickerSelection: Binding<Set<AnyHashable>>? {
        get { self[MultiPickerSelectionKey<AnyHashable>.self] }
        set { self[MultiPickerSelectionKey<AnyHashable>.self] = newValue }
    }
}

public struct MultiPicker<SelectionValue: Hashable, Content: View>: View {
    let content: Content
    @Binding var selection: [SelectionValue]
    private let label: String
    
    public init(_ label: String, selection: Binding<[SelectionValue]>,  @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.label = label
        self.content = content()
    }
    
    public var body: some View {
        Menu {
            content.environment(\.multiPickerSelection, Binding(
                get: { Set(selection.map { AnyHashable($0) }) },
                set: { newValue in
                    selection = newValue.compactMap { $0 as? SelectionValue }
                }
            ))
        } label: {
            HStack {
                Text(label)
                    .foregroundColor(.primary)
                Spacer()
                Text(selectionText)
                    .foregroundColor(.secondary)
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
    }
    
    private var selectionText: String {
        if selection.isEmpty {
            return "<empty>"
        }
        return selection.map{ $0 as! String }.joined(separator: ", ")
    }
}

private struct MultiPickerTagModifier<SelectionValue: Hashable>: ViewModifier {
    let tag: SelectionValue
    @Environment(\.multiPickerSelection) private var selection
    
    func body(content: Content) -> some View {
        if let selection = selection {
            let isSelected = selection.wrappedValue.contains(AnyHashable(tag))
            
            Button {
                if isSelected {
                    selection.wrappedValue.remove(AnyHashable(tag))
                } else {
                    selection.wrappedValue.insert(AnyHashable(tag))
                }
            } label: {
                HStack {
                    content
                    Spacer()
                    if isSelected {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .contentShape(Rectangle())
        } else {
            content
        }
    }
}

public extension View {
    func multiPickerTag<SelectionValue: Hashable>(_ tag: SelectionValue) -> some View {
        modifier(MultiPickerTagModifier(tag: tag))
    }
}
