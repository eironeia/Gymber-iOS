import UIKit
import Shuffle

final class DiscoverGymsViewController: UIViewController {
    private let cardsStackView = SwipeCardStack()

    private let viewModel: DiscoverGymsViewModelInterface
    private var cards: [GymUIModel] = []

    init(viewModel: DiscoverGymsViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        viewModel.getNearbyGyms(completion: { [weak self] result in
            self?.handleGetNearbyGymsResult(result)
        })
    }
}

private extension DiscoverGymsViewController {
    func setupUI() {
        view.backgroundColor = .white
        title = "Nearby gyms"
        cardsStackView.delegate = self
        cardsStackView.dataSource = self
        setupLayout()
    }

    func setupLayout() {
        view.addSubview(cardsStackView)
        cardsStackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            topConstant: 30,
            leadingConstant: 30,
            bottomConstant: 30,
            trailingConstant: 30
        )
    }

    func handleGetNearbyGymsResult(_ result: Result<[GymUIModel], ErrorUIType>) {
        switch result {
        case let .success(uiModels):
            self.cards = uiModels
            DispatchQueue.main.async {
                self.cardsStackView.reloadData()
            }
        case let .failure(error):
            switch error {
            case .somethingWentWrong:
                let alertController = UIAlertController(
                    title: "Oops!",
                    message: "Something went wrong, try again later",
                    preferredStyle: .alert
                )

                let okayAction = UIAlertAction(
                    title: "Okay",
                    style: .destructive
                )

                alertController.addAction(okayAction)

                DispatchQueue.main.async {
                    self.present(alertController, animated: true)
                }
            }
            print(error)
        }
    }
}

extension DiscoverGymsViewController: SwipeCardStackDelegate {
    func cardStack(
        _ cardStack: SwipeCardStack,
        didSwipeCardAt index: Int,
        with direction: SwipeDirection
    ) {
        let id = "" //cards[index].id
        switch direction {
        case .left:
            viewModel.swipeLeft(id: id)
        case .right:
            viewModel.swipeRight(id: id, onMatch: { [weak self] in
                self?.displayMatchAnimation()
            })
        default:
            return
        }
    }

    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("No more cards")
    }

    func displayMatchAnimation() {
        print("Amazing match animation")
    }
}

extension DiscoverGymsViewController: SwipeCardStackDataSource {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .right]
        for direction in card.swipeDirections {
            card.setOverlay(GymberCardOverlay(direction: direction), forDirection: direction)
        }

        let model = cards[index] // TODO: safe index
        card.content = GymberCardContentView(imageUrl: model.imageUrl)
        card.footer = GymberCardFooterView(
            withTitle: "\(model.name)",
            subtitle: "Distance from you: \(model.id)km"
        )

        return card
    }

    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        cards.count
    }
}
