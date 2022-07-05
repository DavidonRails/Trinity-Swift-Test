//
//  ContactsViewController.swift
//  Trinity
//
//  Created by Admin on 2022/7/5.
//

import UIKit


class ContactsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let refreshControl = UIRefreshControl()
    var contacts: [ContactModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getContacts()
    }
    
    func configureView() {
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.lightGray // this effectively hides the native refresh control spinner
        collectionView.refreshControl = refreshControl
    }
    
    @objc func pullRefresh(refreshControl: UIRefreshControl) {
        getContacts()
    }
    
    func getContacts() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                let jsonArry = jsonResult as! [Any]
                contacts = []
                for item in jsonArry {
                    let contact = ContactModel(dict: item as! [String: Any])
                    contacts.append(contact)
                }
                
                collectionView.reloadData()
            } catch {
                
            }
        }
        
        refreshControl.endRefreshing()
    }
    
    @IBAction func onAddContact(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        vc.delegate = self
        vc.contact = ContactModel()
        present(vc, animated: true)
    }
    
}

extension ContactsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contact = contacts[indexPath.item]
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        vc.contact = contact
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension ContactsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCollectionViewCell", for: indexPath) as! ContactCollectionViewCell
        let contact = contacts[indexPath.item]
        cell.lblName.text = "\(contact.firstName) \(contact.lastName)"
        return cell
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = 80
        return CGSize(width: width, height: CGFloat(height))
    }
}

extension ContactsViewController: ContactActionDelegate {
    func savedContact(contact: ContactModel, isNew: Bool) {
        if isNew {
            contacts.insert(contact, at: 0)
            collectionView.reloadData()
        } else {
            collectionView.reloadData()
        }
    }
}
