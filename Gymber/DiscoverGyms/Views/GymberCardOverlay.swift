import UIKit
import Shuffle

final class GymberCardOverlay: UIView {
    init(direction: SwipeDirection) {
        super.init(frame: .zero)
        switch direction {
        case .left:
            createLeftOverlay()
        case .right:
            createRightOverlay()
        default:
            break
        }
    }

    required init?(coder: NSCoder) {
        return nil
    }

}

private extension GymberCardOverlay {
    func createLeftOverlay() {
        let leftTextView = GymberCardOverlayLabelView(
            withTitle: "NOPE",
            color: .red,
            rotation: CGFloat.pi / 10
        )
        addSubview(leftTextView)
        leftTextView.anchor(
            top: topAnchor,
            trailing: trailingAnchor,
            topConstant: 24,
            leadingConstant: 12
        )
    }

    func createRightOverlay() {
        let rightTextView = GymberCardOverlayLabelView(
            withTitle: "LIKE",
            color: .green,
            rotation: -CGFloat.pi / 10
        )
        addSubview(rightTextView)
        rightTextView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            topConstant: 24,
            leadingConstant: 12
        )
    }
}

private class GymberCardOverlayLabelView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    init(withTitle title: String, color: UIColor, rotation: CGFloat) {
        super.init(frame: CGRect.zero)
        layer.borderColor = color.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 4
        transform = CGAffineTransform(rotationAngle: rotation)

        addSubview(titleLabel)
        titleLabel.textColor = color
        titleLabel.attributedText = NSAttributedString(
            string: title,
            attributes: NSAttributedString.Key.overlayAttributes
        )
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            leadingConstant: 8,
            trailingConstant: 3
        )
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension NSAttributedString.Key {
  static var overlayAttributes: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "HelveticaNeue-Bold", size: 42)
        ?? .systemFont(ofSize: 42),
    .kern: 5.0
  ]
}
