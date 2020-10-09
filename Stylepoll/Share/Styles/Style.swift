



import SwiftUI

struct TextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content.padding()
            .border(Color( red: 0, green: 0, blue: 0, opacity: 0.15), width: 1)
            .padding([.leading, .trailing, .top])
    }
}

struct SinginButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.padding()
            .background(Color.black)
            .cornerRadius(5)
            .shadow(radius: 10, x:0, y:10)
            .padding()
    }
}


struct SquishableButtonStyle: ButtonStyle {
    var fadeOnPress = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed && fadeOnPress ? 0.75 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

