# SwiftUIX

SwiftUIX is a Swift Package that provides a collection of reusable SwiftUI components to help you build iOS applications faster.

## Installation

### Swift Package Manager

In Xcode, select File > Add Packages..., then enter this repository's URL:

```
https://github.com/lsongdev/swift-uix.git
```

Or add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/lsongdev/swift-uix.git", from: "0.1.0")
]
```

## Components

### InputField

A field component that supports both text and numeric input.

```swift
import SwiftUIX

struct ContentView: View {
    @State private var name = ""
    @State private var age = 0
    
    var body: some View {
        Form {
            InputField("Name", text: $name)
            InputField("Age", value: $age)
        }
    }
}
```

### PickerInput

A component that combines text input with dropdown selection.

```swift
import SwiftUIX

struct ContentView: View {
    @State private var selectedValue = ""
    let options = ["Option A", "Option B", "Option C"]
    
    var body: some View {
        PickerInput("Select or input", text: $selectedValue, options: options)
    }
}
```

### MultiPicker

A menu component that supports multiple selection.

```swift
import SwiftUIX

struct ContentView: View {
    @State private var selection: [String] = []
    let options = ["Option A", "Option B", "Option C"]
    
    var body: some View {
        MultiPicker("Multiple selection", selection: $selection) {
            ForEach(options, id: \.self) { option in
                Text(option).multiPickerTag(option)
            }
        }
    }
}
```

## License

MIT 