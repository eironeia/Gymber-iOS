import UIKit

final class GymMatchView: UIView {

    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Is a match!"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()

    private lazy var okayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Nice!", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitleColor(.like, for: .normal)
        return button
    }()

    var onCompletion: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupSubtitle(subtitle: String) {
        subtitleLabel.text = subtitle
    }
}

private extension GymMatchView {
    func setupUI() {
        backgroundColor = .white
        setupLayout()
    }

    func setupLayout() {
        addSubview(container)
        [titleLabel, subtitleLabel, okayButton].forEach(container.addArrangedSubview(_:))

        container.anchorCenterSuperview()

        container.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor,
            leadingConstant: 8,
            trailingConstant: 8
        )
    }

    @objc
    func buttonTapped() {
        onCompletion?()
    }
}
