import Foundation
import SwiftUI

extension Warp {
    /// <#Description#>
    public struct InputConfiguration {
        /// <#Description#>
        public let placeholder: String

        /// <#Description#>
        public let title: String?

        /// <#Description#>
        public let additionalInformation: String?

        /// <#Description#>
        public let infoToolTip: Image?

        /// <#Description#>
        public let iconLeft: Image?

        /// <#Description#>
        public let iconRight: Image?

        /// <#Description#>
        public let prefix: String?

        /// <#Description#>
        public let suffix: String?
        
        /// <#Description#>
        public let errorMessage: String?
        
        /// <#Description#>
        public let helpMessage: String?
        
        /// <#Description#>
        public let isAnimated: Bool
        
        /// <#Description#>
        public let lineLimit: ClosedRange<UInt8>

        init() {
            placeholder = ""
            title = nil
            additionalInformation = nil
            infoToolTip = nil
            iconLeft = nil
            iconRight = nil
            prefix = nil
            suffix = nil
            errorMessage = nil
            helpMessage = nil
            isAnimated = true
            lineLimit = 1...1
        }

        init(
            placeholder: String,
            title: String? = nil,
            additionalInformation: String? = nil,
            infoToolTip: Image? = nil,
            iconLeft: Image? = nil,
            iconRight: Image? = nil,
            prefix: String? = nil,
            suffix: String? = nil,
            errorMessage: String? = nil,
            helpMessage: String? = nil,
            isAnimated: Bool = true,
            lineLimit: ClosedRange<UInt8> = .oneLineLimit
        ) {
            self.placeholder = placeholder
            self.title = title
            self.additionalInformation = additionalInformation
            self.infoToolTip = infoToolTip
            self.iconLeft = iconLeft
            self.iconRight = iconRight
            self.prefix = prefix
            self.suffix = suffix
            self.errorMessage = errorMessage
            self.helpMessage = helpMessage
            self.isAnimated = isAnimated
            self.lineLimit = lineLimit
        }
    }
}

extension ClosedRange where Bound == UInt8 {
    public static let oneLineLimit: ClosedRange<UInt8> = 1...1
}
