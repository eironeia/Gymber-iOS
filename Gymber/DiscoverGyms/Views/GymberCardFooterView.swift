import UIKit

class GymberCardFooterView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var gradientLayer: CAGradientLayer?

    override func layoutSubviews() {
        let padding: CGFloat = 24
        let spacing: CGFloat = 4
        titleLabel.frame = CGRect(
            x: padding,
            y: bounds.height
                - titleLabel.intrinsicContentSize.height
                - spacing
                - subtitleLabel.intrinsicContentSize.height
                - padding,
            width: bounds.width - 2 * padding,
            height: titleLabel.intrinsicContentSize.height
        )

        subtitleLabel.frame = CGRect(
            x: padding,
            y: bounds.height
                - subtitleLabel.intrinsicContentSize.height
                - padding,
            width: bounds.width - 2 * padding,
            height: subtitleLabel.intrinsicContentSize.height
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
        [titleLabel, subtitleLabel].forEach(addSubview(_:))
    }

    func setup(title: String?, subtitle: String?) {
        titleLabel.attributedText = NSMutableAttributedString(
            string: (title ?? ""),
            attributes: NSAttributedString.Key.titleAttributes
        )

        if let subtitle = subtitle, !subtitle.isEmpty {
            subtitleLabel.attributedText = NSMutableAttributedString(
                string: subtitle,
                attributes: NSAttributedString.Key.subtitleAttributes
            )
        }
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
        .font: UIFont(name: "ArialRoundedMTBold", size: 20)!,
        .foregroundColor: UIColor.white,
        .shadow: NSAttributedString.Key.shadowAttribute
    ]

    static var subtitleAttributes: [NSAttributedString.Key: Any] = [
        // swiftlint:disable:next force_unwrapping
        .font: UIFont(name: "Arial", size: 16)!,
        .foregroundColor: UIColor.white,
        .shadow: NSAttributedString.Key.shadowAttribute
    ]
}
