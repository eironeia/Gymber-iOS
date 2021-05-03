import UIKit
import Shuffle

final class GymberCardOverlayView: UIView {
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

private extension GymberCardOverlayView {
    func createLeftOverlay() {
        let leftTextView = GymberCardOverlayLabelView(
            title: "NOPE",
            color: .nope
        )
        addSubview(leftTextView)
        leftTextView.anchor(
            top: topAnchor,
            trailing: trailingAnchor,
            topConstant: 12,
            trailingConstant: 12
        )
    }

    func createRightOverlay() {
        let rightTextView = GymberCardOverlayLabelView(
            title: "LIKE",
            color: .like
        )
        addSubview(rightTextView)
        rightTextView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            topConstant: 12,
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

    init(title: String, color: UIColor) {
        super.init(frame: CGRect.zero)
        setupUI()
        setup(title: title, color: color)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

private extension GymberCardOverlayLabelView {
    func setupUI() {
        layer.borderWidth = 4
        layer.cornerRadius = 4

        setupLayout()
    }

    func setupLayout() {
        addSubview(titleLabel)
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            leadingConstant: 8,
            trailingConstant: 8
        )
    }

    func setup(title: String, color: UIColor) {
        layer.borderColor = color.cgColor
        titleLabel.attributedText = NSAttributedString(
            string: title,
            attributes: NSAttributedString.Key.overlayAttributes
        )
        titleLabel.textColor = color
    }
}

extension NSAttributedString.Key {
  static var overlayAttributes: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "HelveticaNeue-Bold", size: 42)
        ?? .systemFont(ofSize: 42),
    .kern: 5.0
  ]
}

extension UIColor {
  static var nope = UIColor(red: 252 / 255, green: 70 / 255, blue: 93 / 255, alpha: 1)
  static var like = UIColor(red: 49 / 255, green: 193 / 255, blue: 109 / 255, alpha: 1)
}
