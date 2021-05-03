import Foundation

public enum SwipeType {
    case left
    case right(onMath: () -> Void)
}
