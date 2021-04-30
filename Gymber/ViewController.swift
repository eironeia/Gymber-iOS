import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gymProvider = GymProvider()
        gymProvider.getNearbyGyms { result in
            print(result)
        }
    }
}

