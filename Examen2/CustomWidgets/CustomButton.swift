//
//  CustomButton.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 29/05/23.
//

import SwiftUI

struct CustomButton: View {
    var body: some View {
        Button(action:{
            // TODO
            
        }){
            Text("Prueba de Boton")
        }.roundedBorder()
    }
}

struct RoundedBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(40)
            .font(.title)
            
    }
    
}

extension View{
    func roundedBorder() -> some View {
        self.modifier(RoundedBorder())
    }
}



struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
