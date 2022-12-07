
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var _imageURL: String = "";
    var vc : UIViewController? = nil;
    var index : Int = 0;
    var _url:String = "";
    var article:Article? = nil;
 
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with imageURL: String, viewController:UIViewController ){
        _imageURL = imageURL;
    }
    
    @IBAction func share(_ sender: Any) {
        let textToShare = title.text

        if let myWebsite = NSURL(string: _url) {
            let objectsToShare: [Any] = [textToShare, myWebsite]
            
            let ac = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            vc?.present(ac, animated: true)
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
                   if(self.article?.title == article.title){
                       Toast.showToast(message: "Article Already Bookmarked", font: .systemFont(ofSize: 12.0), index: index, controller: vc!)
                       return;
                   }
               }
               
               articles.append(Article(
                   source:nil,
                   title: title.text ?? "",
                   description: desc.text,
            
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
                   Toast.showToast(message: "Article Bookmarked", font: .systemFont(ofSize: 12.0), index: index, controller: vc!)
                   } catch {
                       print("Unable to Encode Note (\(error))")
                   }
           } catch {
               print("Unable to Decode Notes (\(error))")
           }
       
    }
    
}
