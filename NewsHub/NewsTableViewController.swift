
import UIKit

class NewsTableViewController: UITableViewController {
    public var category: String? = nil
    private var articles = [Article]()

    @IBAction func allBookmarks(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadData()
    {
        APICaller.shared.getCategoryNews(category : self.category ) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
//                self?.viewModels = articles.compactMap({
//                    NewsTableViewCellViewModel(
//                        title: $0.title,
//                        subtitle: $0.description ?? "No Description",
//                        imageURL: URL(string: $0.urlToImage ?? ""),
//                        url: $0.url ?? ""
//                    )
//                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newstablecell", for: indexPath) as! NewsTableViewCell
        
        let rowNumber = indexPath.row
        let thisRowData = articles[rowNumber]
        
        cell.title.text = thisRowData.title
        cell.desc.text = thisRowData.description
        cell.vc = self;
        cell.index = rowNumber;
        cell._url = thisRowData.url!
        cell.article = articles[rowNumber]
        
        let url = URL(string: ((thisRowData.urlToImage == nil || thisRowData.urlToImage == "" ) ? "https://kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg" : thisRowData.urlToImage)!)
        
        DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.img.image = image
                            }
                        }
                    }
                }
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]

        if let secondViewController = storyboard?.instantiateViewController(withIdentifier: "detailview") as? DetailViewController {
           // Pass Data
            secondViewController.article = article
           // Present Second View
            show(secondViewController, sender: true)
        }
//        let vc = DetailViewController(article: article)


//        navigationController?.pushViewController(vc, animated: true)
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "detailview" {
              guard let secondViewController = segue.destination as? DetailViewController else { return }
              // Pass Data to Second View Controller
//            secondViewController.article = sender
          }
    }
    

}
