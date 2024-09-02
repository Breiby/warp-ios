import SwiftUI

extension Warp {
    /// A single checkbox view used within `CheckboxGroup`.
    ///
    /// Displays a selectable icon with a label. The checkbox can be in one of three states:
    /// not selected, selected, or partially selected, and it can have different styles.
    ///
    /// - Parameters:
    ///   - label: The text label for the checkbox.
    ///   - initialState: The initial state of the checkbox (notSelected, selected, partiallySelected).
    ///   - style: The style of the checkbox (default, error, disabled).
    ///   - extraContent: A view that will be displayed beside or below the label.
    ///   - indentationLevel: The level of indentation for the checkbox. Each level adds 24 points of indentation.
    public struct Checkbox: View {
        /// The text label for the checkbox.
        var label: String
        /// The state of the checkbox (notSelected, selected, partiallySelected).
        @State private var state: CheckboxState
        /// The style of the checkbox (default, error, disabled).
        var style: CheckboxStyle
        /// An optional view that will be displayed beside or below the label.
        var extraContent: AnyView?
        /// The level of indentation for the checkbox. Each level adds 24 points of indentation.
        var indentationLevel: Int = 0
        /// Object that will provide needed colors.
        private let colorProvider: ColorProvider = Warp.Color
        
        /// Initializes a new `Checkbox`.
        ///
        /// - Parameters:
        ///   - label: The text label for the checkbox.
        ///   - initialState: The initial state of the checkbox (notSelected, selected, partiallySelected).
        ///   - style: The style of the checkbox (default, error, disabled).
        ///   - extraContent: An optional view that will be displayed beside or below the label.
        ///   - indentationLevel: The level of indentation for the checkbox. Each level adds 24 points of indentation.
        public init(label: String,
                    initialState: CheckboxState = .notSelected,
                    style: CheckboxStyle = .default,
                    extraContent: AnyView? = nil,
                    indentationLevel: Int = 0) {
            self.label = label
            self._state = State(initialValue: initialState)
            self.style = style
            self.extraContent = extraContent
            self.indentationLevel = indentationLevel
        }
        
        public var body: some View {
            HStack(alignment: .top, spacing: Spacing.spacing100) {
                Spacer()
                    .frame(width: CGFloat(indentationLevel) * Spacing.spacing300)
                
                ZStack {
                    Rectangle()
                        .fill(backgroundColor)
                        .frame(width: 20, height: 20)
                        .cornerRadius(4)
                    
                    if state == .selected {
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(colorProvider.checkboxBackground)
                            .frame(width: 12, height: 12)
                    } else if state == .partiallySelected {
                        Image(systemName: "minus")
                            .resizable()
                            .foregroundColor(colorProvider.checkboxBackground)
                            .frame(width: 12, height: 2)
                    }
                    
                    if state == .notSelected {
                        Rectangle()
                            .foregroundColor(borderColor)
                            .cornerRadius(4)
                            .frame(width: 20, height: 20)
                        
                        Rectangle()
                            .foregroundColor(backgroundColor)
                            .cornerRadius(4)
                            .frame(width: 19, height: 19)
                    }
                }
                
                contentStack
                
                Spacer()
            }
            .onTapGesture {
                if style != .disabled {
                    toggleState()
                }
            }
        }
        
        @ViewBuilder
        private var contentStack: some View {
            HStack(alignment: .top, spacing: Spacing.spacing100) {
                SwiftUI.Text(label)
                    .font(Typography.body.font)
                    .foregroundColor(textColor)
                if let extraContent = extraContent {
                    extraContent
                }
            }
        }
        
        private var borderColor: Color {
            switch style {
            case .default:
                return colorProvider.checkboxBorder
            case .error:
                return colorProvider.checkboxNegativeBorder
            case .disabled:
                return colorProvider.checkboxBorderDisabled
            }
        }
        
        private var backgroundColor: Color {
            switch (state, style) {
            case (.selected, .default):
                return colorProvider.checkboxBackgroundSelected
            case (.selected, .error):
                return colorProvider.checkboxNegativeBackgroundSelected
            case (.selected, .disabled):
                return colorProvider.checkboxBackgroundSelectedDisabled
            case (.partiallySelected, .default):
                return colorProvider.checkboxBackgroundSelected
            case (.partiallySelected, .error):
                return colorProvider.checkboxNegativeBackgroundSelected
            case (.partiallySelected, .disabled):
                return colorProvider.checkboxBackgroundSelectedDisabled
            case (.notSelected, .default):
                return colorProvider.checkboxBackground
            case (.notSelected, .error):
                return colorProvider.checkboxBackground
            case (.notSelected, .disabled):
                return colorProvider.checkboxBackgroundDisabled
            }
        }
        
        private var textColor: Color {
            switch style {
            case .default, .error:
                return colorProvider.token.text
            case .disabled:
                return colorProvider.token.textDisabled
            }
        }
        
        private func toggleState() {
            switch state {
            case .notSelected:
                state = .partiallySelected
            case .partiallySelected:
                state = .selected
            case .selected:
                state = .notSelected
            }
        }
    }
}
