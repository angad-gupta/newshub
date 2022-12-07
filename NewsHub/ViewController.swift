
import UIKit

class ViewController: UIViewController {
    private var articles = [Article]()
   
    @IBOutlet weak var NewArticle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }


}

