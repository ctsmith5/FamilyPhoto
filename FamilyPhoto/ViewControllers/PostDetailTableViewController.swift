//
//  PostDetailTableViewController.swift
//  FamilyPhoto
//
//  Created by Colin Smith on 6/17/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {

    
    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    //Reciever
    var post: Post?{
        didSet{
            updateViews()
        }
    }
    var postController = PostController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func updateViews(){
        self.postPhoto.image = post?.photo
        self.captionLabel.text = post?.caption
        self.tableView.reloadData()
    }
    
    //MARK: - Button Actions
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        let commentAlert = UIAlertController(title: "Add a New Comment", message: "Say something about this photo...", preferredStyle: .alert)
        commentAlert.addTextField { (textField) in
            textField.placeholder = "Enter Text..."
        }
        
        
        let postAction = UIAlertAction(title: "Add", style: .default) { (addPost) in
            if let bodyText = commentAlert.textFields?[0].text,
                let post = self.post{
                self.postController.addComment(text: bodyText, post: post) { (post) in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        commentAlert.addAction(postAction)
        commentAlert.addAction(cancelAction)
        self.tableView.reloadData()
        self.present(commentAlert, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func followButtonPressed(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        cell.textLabel?.text = post?.comments[indexPath.row].timestamp.description
        cell.detailTextLabel?.text = post?.comments[indexPath.row].text
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
}
