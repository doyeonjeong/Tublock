//
//  SelectingView.swift
//  Tublock
//
//  Created by DOYEON JEONG on 2023/07/24.
//

import SwiftUI

struct SelectingView: View {
    
    @EnvironmentObject var viewModel: BlockingManager
    @State var isPresented = true
    
    var body: some View {
        EmptyView()
        .familyActivityPicker(isPresented: $isPresented, selection: $viewModel.newSelection)
    }
}

struct SelectingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectingView()
    }
}


