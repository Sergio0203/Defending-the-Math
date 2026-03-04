import SwiftUI
import SpriteKit


struct ContentView: View {
    @State var fontNormal: Font?
    @State var fontBold: Font?
    @State var fontLight: Font?

        var body: some View {
        VStack {
            SpriteView(scene: SceneManager.shared.getScene(ofType: .home)!)
                .ignoresSafeArea()
        }
        .task {
            fontNormal = NodesTools.getFont(typeFont: .regular)
            fontBold = NodesTools.getFont(typeFont: .bold)
            fontLight = NodesTools.getFont(typeFont: .light)
        }
    }
}

