import UIKit
import Network
import Domain

struct DiscoverGymsFactory {
    func makeDiscoverGymsViewController() -> UIViewController {
        let gymProvider = GymProvider()
        let swipeProvider = SwipeProvider()
        let useCase = DiscoverGymsUseCase(
            gymProvider: gymProvider,
            swipeProvider: swipeProvider
        )
        let locationHandler = LocationAuthorizationHandler()
        let viewModel = DiscoverGymsViewModel(useCase: useCase)
        return DiscoverGymsViewController(viewModel: viewModel, locationHandler: locationHandler)
    }
}
