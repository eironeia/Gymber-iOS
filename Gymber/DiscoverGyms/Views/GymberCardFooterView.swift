import UIKit

class GymberCardFooterView: UIView {

    private let label = UILabel()
    private var gradientLayer: CAGradientLayer?

    override func layoutSubviews() {
        let padding: CGFloat = 24
        label.frame = CGRect(
            x: padding,
            y: bounds.height - label.intrinsicContentSize.height - padding,
            width: bounds.width - 2 * padding,
            height: label.intrinsicContentSize.height
        )
    }

    init(title: String?, subtitle: String?) {
        super.init(frame: CGRect.zero)
        setupUI()
        setup(title: title, subtitle: subtitle)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {
        backgroundColor = .clear
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 10
        clipsToBounds = true
        isOpaque = false
        setupLayout()
    }

    func setupLayout() {
        addSubview(label)
    }

    func setup(title: String?, subtitle: String?) {
        let attributedText = NSMutableAttributedString(
            string: (title ?? "") + "\n",
            attributes: NSAttributedString.Key.titleAttributes
        )
        if let subtitle = subtitle, !subtitle.isEmpty {
            attributedText.append(
                NSMutableAttributedString(
                    string: subtitle,
                    attributes: NSAttributedString.Key.subtitleAttributes
                )
            )
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.lineBreakMode = .byTruncatingTail
            attributedText.addAttributes([.paragraphStyle: paragraphStyle],
                                         range: NSRange(location: 0, length: attributedText.length))
            label.numberOfLines = 2
        }

        label.attributedText = attributedText
    }
}

extension NSAttributedString.Key {
    static var shadowAttribute: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 2
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        return shadow
    }()

    static var titleAttributes: [NSAttributedString.Key: Any] = [
        // swiftlint:disable:next force_unwrapping
        .font: UIFont(name: "ArialRoundedMTBold", size: 24)!,
        .foregroundColor: UIColor.white,
        .shadow: NSAttributedString.Key.shadowAttribute
    ]

    static var subtitleAttributes: [NSAttributedString.Key: Any] = [
        // swiftlint:disable:next force_unwrapping
        .font: UIFont(name: "Arial", size: 17)!,
        .foregroundColor: UIColor.white,
        .shadow: NSAttributedString.Key.shadowAttribute
    ]
}
