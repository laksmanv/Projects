import Foundation

class MainScene: CCNode {

    func startGame() {
        let firstLevel = CCBReader.loadAsScene("Level1")
        let transition = CCTransition(fadeWithDuration: 0.8)
        CCDirector.sharedDirector().presentScene(firstLevel, withTransition: transition)
    }
}
