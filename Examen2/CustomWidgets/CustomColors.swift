import SwiftUI

struct CustomColors: View {
    var body: some View {
        VStack {
            Button(action: {
                // Acción del botón 1
            }) {
                Text("Botón 1")
            }
            .buttonStyle(CustomButtonStyle()) // Aplicar el estilo personalizado al botón 1

            Button(action: {
                // Acción del botón 2
            }) {
                Text("Botón 2")
            }
            .buttonStyle(CustomButtonStyle()) // Aplicar el estilo personalizado al botón 2
        } // Establecer el color de fondo utilizando el valor hexadecimal
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .background(Color(hex: "#90BE6D"))
            .cornerRadius(10)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b, a: UInt64
        switch hex.count {
        case 3:
            (r, g, b, a) = (
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17,
                255
            )
        case 6:
            (r, g, b, a) = (
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF,
                255
            )
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct CustomColors_Previews: PreviewProvider {
    static var previews: some View {
        CustomColors()
    }
}
