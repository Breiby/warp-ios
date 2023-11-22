import Foundation
import SwiftUI

/// Minimum height reserved for text field in order to keep it elegant.
private let textFieldMinHeight = 28.0

extension Warp {
    /// Text field style that will be used internally.
    /// Responsible for configuring text field inside the borders.
    struct InnerInputStyle: TextFieldStyle {
        /// State of input.
        let state: Warp.InputState
        
        /// View that can be added as a helper in left side of the text field.
        let leftView: AnyView?
        
        /// View that can be added as a helper in right side of the text field.
        let rightView: AnyView?
        
        /// Object responsible for providing needed colors.
        let colorProvider: ColorProvider

        private var cornerRadius: CGFloat {
            4.0
        }

        private var borderColor: Color {
            switch state {
                case .normal:
                    return colorProvider.inputBorder

                case .active:
                    return colorProvider.inputBorderActive

                case .disabled:
                    return colorProvider.inputBorderDisabled

                case .error:
                    return colorProvider.inputBorderNegative

                case .readOnly:
                    return colorProvider.inputBorder
            }
        }

        private var backgroundColor: Color {
            if state == .disabled {
                return colorProvider.inputBackgroundDisabled
            }

            return colorProvider.inputBackground
        }

        private var inputBorderWidth: CGFloat {
            switch state {
                case .normal:
                    return 2

                case .active:
                    return 4

                case .disabled:
                    return 2

                case .error:
                    return 2

                case .readOnly:
                    return 0
            }
        }

        private var horizontalPadding: CGFloat {
            state == .readOnly ? 4 : 8
        }

        private var additionalViewForegroundColor: Color {
            FinnColors.gray500
        }

        public func _body(configuration: TextField<Self._Label>) -> some View {
            HStack(spacing: 8) {
                if let leftView = leftView {
                    createAdditionalView(from: leftView)
                }

                configuration
                    .frame(minHeight: textFieldMinHeight, maxHeight: .infinity)
                    .font(.callout)

                if let rightView = rightView {
                    createAdditionalView(from: rightView)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .overlay(overlayView)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }

        private var overlayView: some View {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: inputBorderWidth)
        }

        private func createAdditionalView(from view: some View) -> some View {
            return view
                .foregroundColor(additionalViewForegroundColor)
                .inputAdditionalView()
        }
    }
}

extension TextFieldStyle where Self == Warp.InnerInputStyle {
    /// A text field style with ability to add arbitrary view in left or right side.
    static func innerStyle(
        state: Warp.InputState,
        leftView: AnyView? = nil,
        rightView: AnyView? = nil,
        colorProvider: ColorProvider
    ) -> Warp.InnerInputStyle {
        Warp.InnerInputStyle(
            state: state,
            leftView: leftView,
            rightView: rightView,
            colorProvider: colorProvider
        )
    }
}
