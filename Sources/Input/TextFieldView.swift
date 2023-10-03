import Foundation
import SwiftUI

struct TextFieldView: View {
    /// <#Description#>
    let placeholder: String

    /// <#Description#>
    let text: Binding<String>

    /// <#Description#>
    let isAnimated: Bool

    /// <#Description#>
    let lineLimit: ClosedRange<UInt8>

    /// <#Description#>
    var isFocused: FocusState<Bool>.Binding

    /// <#Description#>
    @Binding var state: Warp.InputState

    private var minHeight: CGFloat {
        28.0
    }

    var body: some View {
        TextField(
            placeholder,
            text: text,
            onEditingChanged: { startedEditing in
                let updateState = {
                    if startedEditing {
                        _state.wrappedValue = .active
                    } else {
                        _state.wrappedValue = .normal
                    }
                }

                if isAnimated {
                    withAnimation {
                        updateState()
                    }
                } else {
                    updateState()
                }
            }
        )
        .focused(isFocused)
        .frame(minHeight: minHeight, maxHeight: .infinity)
        .textFieldStyle(
            .innerStyle(
                state: state,
                lineLimit: lineLimit
            )
        )
    }
}
