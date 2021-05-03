import UIKit
import Kingfisher

final class GymberCardContentView: UIView {
    private let backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = .white
        background.clipsToBounds = true
        background.layer.cornerRadius = 10
        return background
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.01).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let heightFactor: CGFloat = 0.35
        gradientLayer.frame = CGRect(
            x: 0,
            y: (1 - heightFactor) * bounds.height,
            width: bounds.width,
            height: heightFactor * bounds.height
        )
    }
    
    init(imageUrl: String?) {
        super.init(frame: .zero)
        setupUI()
        setup(imageUrl: imageUrl)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setup(imageUrl: String?) {
        if let imageUrl = imageUrl,
           let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
        } else {
            imageView.image = UIImage(named: "placeholderImage")
        }
    }
}

private extension GymberCardContentView {
    func setupUI() {
        setupLayout()
        applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
        backgroundView.layer.insertSublayer(gradientLayer, above: imageView.layer)
    }

    func setupLayout() {
        addSubview(backgroundView)
        backgroundView.fillSuperview()
        backgroundView.addSubview(imageView)
        imageView.fillSuperview()

    }
}
