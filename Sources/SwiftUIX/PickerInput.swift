import SwiftUI

public struct PickerInput<SelectionValue: Hashable>: View {
    let label: String
    @Binding var text: String
    let placeholder: String
    let options: [SelectionValue]
    let optionToString: (SelectionValue) -> String
    
    public init(
        _ label: String,
        text: Binding<String>,
        options: [SelectionValue],
        optionToString: @escaping (SelectionValue) -> String = String.init(describing:),
        placeholder: String = ""
    ) {
        self.label = label
        self._text = text
        self.options = options
        self.optionToString = optionToString
        self.placeholder = placeholder
    }
    
    public var body: some View {
        HStack {
            Text(label)
            Spacer()
            TextField(placeholder, text: $text)
                .multilineTextAlignment(.trailing)
                .autocorrectionDisabled(true)
            Menu {
                Button(action: { text = "" }) {
                    Text("<empty>")
                }
                ForEach(options, id: \.self) { option in
                    Button(action: { text = optionToString(option) }) {
                        Text(optionToString(option))
                    }
                }
            } label: {
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
    }
}
