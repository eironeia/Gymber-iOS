import UIKit
import Network

struct DiscoverGymsFactory {
    func makeDiscoverGymsViewController() -> UIViewController {
        let gymProvider = GymProvider()
        let swipeProvider = SwipeProvider()
        let useCase = DiscoverGymsUseCase(
            gymProvider: gymProvider,
            swipeProvider: swipeProvider
        )
        let viewModel = DiscoverGymsViewModel(useCase: useCase)
        return DiscoverGymsViewController(viewModel: viewModel)
    }
}