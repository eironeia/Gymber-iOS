import Foundation

public enum SwipeType {
    case left
    case right(onMatch: (Int) -> Void)
}
