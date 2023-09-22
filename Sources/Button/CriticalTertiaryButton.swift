import Foundation
import SwiftUI

extension Warp.Button {
    /// <#Description#>
    static func createCriticalTertiary(
        title: String,
        icon: String? = nil,
        action: @escaping () -> Void,
        size: Warp.ButtonSize = .big,
        isEnabled: Bool = false,
        fullWidth: Bool = false
    ) -> Warp.Button {
        Warp.Button(
            title: title,
            icon: icon,
            action: action,
            type: .criticalTertiary,
            size: size,
            isEnabled: isEnabled,
            fullWidth: fullWidth
        )
    }
}

public struct CriticalTertiaryButton: View {
    /// <#Description#>
    let title: String

    /// <#Description#>
    let icon: String?

    /// <#Description#>
    let action: () -> Void

    /// <#Description#>
    let size: Warp.ButtonSize

    /// <#Description#>
    let isEnabled: Bool

    /// <#Description#>
    let fullWidth: Bool

    public init(
        title: String,
        icon: String?,
        action: @escaping () -> Void,
        size: Warp.ButtonSize,
        isEnabled: Bool,
        fullWidth: Bool
    ) {
        self.title = title
        self.icon = icon
        self.action = action
        self.size = size
        self.isEnabled = isEnabled
        self.fullWidth = fullWidth
    }

    public var body: some View {
        Warp.Button.createCriticalTertiary(
            title: title,
            icon: icon,
            action: action,
            size: size,
            isEnabled: isEnabled,
            fullWidth: fullWidth
        )
    }
}

private struct CriticalTertiaryButtonPreview: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 8) {
            Warp.Button.createCriticalTertiary(title: "Button", action: {})

            Warp.Button.createCriticalTertiary(title: "Disabled button", action: {}, isEnabled: false)
        }
    }
}
