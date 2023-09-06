import SwiftUI

public struct TertiaryButton: View {
    let title: String
    let icon: String
    let size: WarpButtonSize
    let disabled: Bool
    let fullWidth: Bool
    let colorProvider = Config.colorProvider

    public init(title: String,
                icon: String = "",
                size: WarpButtonSize = .big,
                disbled: Bool = false,
                fullWidth: Bool = false) {
        self.title = title
        self.icon = icon
        self.size = size
        self.disabled = disbled
        self.fullWidth = fullWidth
    }
        
    public var body: some View {
        WarpButton(title: title,
                   icon: icon,
                   type: .tertiary,
                   size: size,
                   disbled: disabled,
                   fullWidth: fullWidth)
    }
}

private struct TertiaryButtonPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            TertiaryButton(title: "Button")
            TertiaryButton(title: "Button", disbled: true)
        }
    }
}
