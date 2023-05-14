//
//  BlockingSwiftUIView.swift
//  Tublock
//
//  Created by Doyeon on 2023/05/14.
//

import SwiftUI

struct BlockingSwiftUIView: View {
    @EnvironmentObject var model: BlockingApplicationModel
    @State var isPresented = false
    
    var body: some View {
        VStack {
            Button(action: { isPresented.toggle() }) {
                Text("차단할 앱 목록 확인하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 54)
                    .background(Color(red: 0.18, green: 0.18, blue: 0.18))
                    .cornerRadius(8)
            }
            .familyActivityPicker(isPresented: $isPresented, selection: $model.newSelection)
        }
    }
}

struct BlockingView_Previews: PreviewProvider {
    static var previews: some View {
        BlockingSwiftUIView()
    }
}
