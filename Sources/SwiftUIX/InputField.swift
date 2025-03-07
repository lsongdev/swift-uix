import SwiftUI

public enum InputFieldType<T> {
    case text(Binding<String>)
    case number(Binding<Int>)
}

public struct InputField<T>: View {
    private var label: String
    private var placeholder: String
    private var inputType: InputFieldType<T>
    
    // Text 类型初始化器
    public init(_ label: String, text: Binding<String>, placeholder: String = "") where T == String {
        self.label = label
        self.placeholder = placeholder
        self.inputType = .text(text)
    }
    
    // 数值类型初始化器
    public init(_ label: String, value: Binding<Int>, placeholder: String = "") where T == Int {
        self.label = label
        self.placeholder = placeholder
        self.inputType = .number(value)
    }
    
    public var body: some View {
        HStack {
            Text(label)
            Spacer()
            switch inputType {
            case .text(let textBinding):
                TextField(placeholder, text: textBinding)
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled()
            case .number(let numberBinding):
                TextField(placeholder, value: numberBinding, formatter: NumberFormatter())
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}
