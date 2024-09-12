import SwiftUI

extension Warp {
    /// Radio buttons allow users to select one option from a set.
    ///
    /// `RadioGroup` is a customizable component that allows users
    /// to create a list of radio buttons where only one can be selected at any given time.
    /// The radio buttons can be aligned either vertically or horizontally.
    ///
    /// - Parameters:
    ///   - title: An optional title for the radio group.
    ///   - helpText: An optional help text displayed below the title or the radio buttons.
    ///   - selectedOption: A binding to the currently selected option.
    ///   - options: An array of options that conform to `RadioOption`.
    ///   - label: A closure that provides a label for each option.
    ///   - style: The style of the radio button group (default, error, disabled).
    ///   - extraContent: A view that will be displayed beside or below the label.
    ///   - axis: Determines whether the list of radio buttons is aligned vertically or horizontally.
    ///   - onSelection: A closure that will be triggered when an option is selected, providing the old and new selection.
    public struct RadioGroup<Option: RadioOption>: View {
        /// An optional title for the radio group.
        var title: String?
        /// An optional help text displayed below the title or the radio buttons.
        var helpText: String?
        /// A binding to the currently selected option.
        @Binding var selectedOption: Option
        /// An array of options that conform to `RadioOption`.
        var options: [Option]
        /// A closure that provides a label for each option.
        var label: (Option) -> String
        /// The style the radio group can have (default, error, disabled).
        var style: RadioStyle
        /// An optional view that will be displayed beside or below the label.
        var extraContent: ((Option) -> AnyView)?
        /// Determines whether the list of radio buttons is aligned vertically or horizontally.
        var axis: Axis.Set
        /// A closure that will be triggered when an option is selected, providing the old and new selection.
        var onSelection: ((Option, Option) -> Void)?
        /// Object that will provide needed colors.
        private let colorProvider: ColorProvider = Warp.Color
        
        /// Initializes a new `RadioGroup`.
        ///
        /// - Parameters:
        ///   - title: An optional title for the radio group.
        ///   - helpText: An optional help text displayed below the title or the radio buttons.
        ///   - selectedOption: A binding to the currently selected option.
        ///   - options: An array of options that conform to `RadioOption`.
        ///   - label: A closure that provides a label for each option.
        ///   - style: The style the radio group can have (default, error, disabled).
        ///   - extraContent: A view that will be displayed beside or below the label.
        ///   - axis: Determines whether the list of radio buttons is aligned vertically or horizontally.
        ///   - onSelection: A closure that will be triggered when an option is selected, providing the old and new selection.
        public init(title: String? = nil,
                    helpText: String? = nil,
                    selectedOption: Binding<Option>,
                    options: [Option],
                    label: @escaping (Option) -> String,
                    style: RadioStyle = .default,
                    extraContent: ((Option) -> AnyView)? = nil,
                    axis: Axis.Set = .vertical,
                    onSelection: ((Option, Option) -> Void)? = nil) {
            self.title = title
            self.helpText = helpText
            self._selectedOption = selectedOption
            self.options = options
            self.label = label
            self.style = style
            self.extraContent = extraContent
            self.axis = axis
            self.onSelection = onSelection
        }
        
        public var body: some View {
            VStack(alignment: .leading, spacing: Spacing.spacing200) {
                if let title = title, !title.isEmpty {
                    SwiftUI.Text(title)
                        .font(Typography.title5.font)
                        .foregroundColor(colorProvider.token.text)
                }
                
                groupView
                
                if let helpText = helpText, !helpText.isEmpty {
                    SwiftUI.Text(helpText)
                        .font(Typography.detail.font)
                        .foregroundColor(helpTextColor)
                }
            }
        }
        
        private var helpTextColor: Color {
            style == .error ? colorProvider.token.textNegative : colorProvider.token.textSubtle
        }
        
        @ViewBuilder
        private var groupView: some View {
            switch axis {
            case .vertical:
                VStack(alignment: .leading, spacing: Spacing.spacing200) {
                    ForEach(options) { option in
                        Radio(isSelected: selectedOption == option,
                              label: label(option),
                              style: style,
                              extraContent: extraContent?(option)) {
                            let oldSelection = selectedOption
                            selectedOption = option
                            onSelection?(oldSelection, option)
                        }
                              .disabled(style == .disabled)
                    }
                }
            case .horizontal, _:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: Spacing.spacing200) {
                        ForEach(options) { option in
                            Radio(isSelected: selectedOption == option,
                                  label: label(option),
                                  style: style,
                                  extraContent: extraContent?(option)) {
                                let oldSelection = selectedOption
                                selectedOption = option
                                onSelection?(oldSelection, option)
                            }
                                  .disabled(style == .disabled)
                        }
                    }
                }
            }
        }
    }
}
