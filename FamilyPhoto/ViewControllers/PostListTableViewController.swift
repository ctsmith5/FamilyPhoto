//
//  PostListTableViewController.swift
//  FamilyPhoto
//
//  Created by Colin Smith on 6/17/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching: Bool = false
    var resultsArray: [Post] = []
    var posts: [Post] = []
    
    var dataSource: [Post] {
        if isSearching{
            return resultsArray
        }else{
            return PostController.shared.posts
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posts = PostController.shared.posts
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resultsArray = PostController.shared.posts
    
    }
    
    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        cell.postImage.image = self.posts[indexPath.row].photo
        cell.postCaption.text = self.posts[indexPath.row].caption
        cell.commentLabel.text = "Comments: \(self.posts[indexPath.row].comments.count)"
        return cell
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
        
    }
    

}// End of class

//MARK: - Extension

extension PostListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultsArray = dataSource.filter({ (post) -> Bool in
            self.isSearching = true
            return post.matches(searchTerm: searchText)
        })
        tableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearching = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.reloadData()
        self.isSearching = false
    }
}
