import UIKit
import Shuffle

final class DiscoverGymsViewController: UIViewController {
    private let cardsStackView = SwipeCardStack()

    private let viewModel: DiscoverGymsViewModelInterface
    private var cards: [GymUIModel] = []

    private lazy var matchView: GymMatchView = {
        let matchView = GymMatchView()
        matchView.isHidden = true
        matchView.onCompletion = hideMatchView
        return matchView
    }()

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

        view.addSubview(matchView)
        matchView.fillSuperview()
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

    func showMatchView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.matchView.isHidden = false
            self.matchView.alpha = 1
        })
    }

    func hideMatchView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.matchView.alpha = 0
        }) { finished in
            self.matchView.isHidden = true
        }
    }
}

extension DiscoverGymsViewController: SwipeCardStackDelegate {
    func cardStack(
        _ cardStack: SwipeCardStack,
        didSwipeCardAt index: Int,
        with direction: SwipeDirection
    ) {
        let id = cards[index].id
        switch direction {
        case .left:
            viewModel.swipeLeft(id: id)
        case .right:
            viewModel.swipeRight(id: id, onMatch: { [weak self] id in
                guard let uiModel = self?.cards.first(where: { $0.id == id }) else { return }
                self?.displayMatchAnimation(for: uiModel)
            })
        default:
            return
        }
    }

    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("No more cards")
    }

    func displayMatchAnimation(for uiModel: GymUIModel) {
        DispatchQueue.main.async {
            self.matchView.setupSubtitle(subtitle: uiModel.name)
            self.showMatchView()
        }
    }
}

extension DiscoverGymsViewController: SwipeCardStackDataSource {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right]
        for direction in card.swipeDirections {
            card.setOverlay(GymberCardOverlayView(direction: direction), forDirection: direction)
        }

        let model = cards[index]
        card.content = GymberCardContentView(imageUrl: model.imageUrl)
        card.footer = GymberCardFooterView(
            title: model.name,
            subtitle: model.distanceText
        )

        return card
    }

    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        cards.count
    }
}
