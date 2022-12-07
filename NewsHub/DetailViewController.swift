
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var dimg: UIImageView!
    @IBOutlet weak var ddesc: UILabel!
    @IBOutlet weak var dtitle: UILabel!
    public var article:Article? = nil;
    
//    init(article: Article) {
//        self.article = article
//
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    @IBAction func share(_ sender: Any) {
        let textToShare = article?.title

        if let myWebsite = NSURL(string: (article?.url)!) {
            let objectsToShare: [Any] = [textToShare, myWebsite]
            
            let ac = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(ac, animated: true)
        }
    }
    
    @IBAction func bookmark(_ sender: Any) {
        let articlesJson = UserDefaults.standard.data(forKey: "bookmarks")
        var articles: [Article] = []
           do {
               if(articlesJson != nil){
               // Create JSON Decoder
               let decoder = JSONDecoder()

               // Decode Note
               let notes = try decoder.decode([Article].self, from: articlesJson!)
               
               
      
               articles = notes
               }
               for article in articles {
                   if(dtitle.text == article.title){
                       Toast.showToast(message: "Article Already Bookmarked", font: .systemFont(ofSize: 12.0), index: 4, controller: self)
                       return;
                   }
               }
               
               articles.append(Article(
                   source:nil,
                   title: article?.title ?? "",
                   description: article?.description,
            
                   url: "", urlToImage: article?.urlToImage,
                   publishedAt: ""
                   
               ));
//                articles = []
               
               
               let encoder = JSONEncoder()

               do {  // Encode Note
                   let data = try encoder.encode(articles)

                  // Write/Set Data
                  UserDefaults.standard.set(data, forKey: "bookmarks")
//                   UIAlertController(title:"Article Bookmarked", message: "Message", preferredStyle: .alert) .addAction(UIAlertAction(title:"Article Bookmarked", style: .cancel, handler: nil))
                   Toast.showToast(message: "Article Bookmarked", font: .systemFont(ofSize: 12.0), index: 4, controller: self)
                   } catch {
                       print("Unable to Encode Note (\(error))")
                   }
           } catch {
               print("Unable to Decode Notes (\(error))")
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dtitle.text = article?.title
        ddesc.text = article?.description
        
        
        let url = URL(string: article?.urlToImage ?? "https://kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg")!
        DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async { [self] in
                                self?.dimg.image = image
                            }
                        }
                    }
                }
        

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        self.dtitle.text = "asdasd";
//        self.ddesc.text = "asd";
//    }
    

}
