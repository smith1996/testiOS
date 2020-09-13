//
//  ViewController.swift
//  iOSTest
//
//  Created by Smith Huamani Hilario on 9/11/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import AVKit

class ProfileViewController: UIViewController {
    
    // MARK: - Constraints
    
    @IBOutlet weak var constraintHeightOfScrollView: NSLayoutConstraint!//Borrar
    @IBOutlet weak var constraintHeightOfHeaderView: NSLayoutConstraint!
    @IBOutlet weak var constrainTopOfVideoTableView: NSLayoutConstraint!
    
    // MARK: - Declared Outlet
    
    @IBOutlet weak var videoTableView: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!//BorrR
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var followMainView: UIView!
    @IBOutlet weak var profileDataStackView: UIStackView!
    
    
    // MARK: - Declared Variables

    lazy var dataService: ProfileDataService = {
        return ProfileDataService()
    }()
    
    lazy var headerViewMaxHeight: CGFloat = 322.0
    lazy var headerViewMinHeight: CGFloat = 60.0
    lazy var isExpanded: Bool = true
    lazy var listOfVideo: [Video] = [Video]()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(tableView: videoTableView, cell: "VideoCell")
        videoTableView.dataSource = self
        videoTableView.delegate = self
        
        getVideos()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        nameLabel.text = " "
        headerView.roundCorners([.bottomLeft, .bottomRight], radius: 30.0)
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        editProfileButton.layer.cornerRadius = 10.0
        followMainView.layer.cornerRadius = 20.0
    }
    
    func getVideos() {
        dataService.fetchVideos { [weak self] result in
            switch result {
            case .success(let item):
                guard let profile = self else { return }
                guard item.count != 0 else { return }
                
                profile.listOfVideo = item
                profile.videoTableView.reloadData()
                
            case .failure(let error):
                guard let profile = self else { return }
                print("Error de Servicio: ", error.localizedDescription)
                print(profile.listOfVideo)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "segueEditProfile":
            let _ = segue.destination as! EditProfileViewController
            //Pasamos data
        default:
            break
        }
    }
    
    @IBAction func editProfilePressedButton() {
        performSegue(withIdentifier: "segueEditProfile", sender: nil)
    }
    

}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfVideo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550.0//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell else {
            fatalError("No existe Cell en Storyboard")
        }
        cell.video = listOfVideo[indexPath.row]
        
        return cell
        
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset

        let newHeaderViewHeight = constraintHeightOfHeaderView.constant - contentOffset.y
        
        if newHeaderViewHeight <= (headerViewMaxHeight - 1.0) && isExpanded {
            constraintHeightOfHeaderView.constant = headerViewMinHeight
            constrainTopOfVideoTableView.constant = 0.0
            nameLabel.text = "TestiOS"
            profileDataStackView.isHidden = true
            headerView.backgroundColor = #colorLiteral(red: 0.05939316005, green: 0.05796413869, blue: 0.105387114, alpha: 1)
            isExpanded = false
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
         } else if newHeaderViewHeight > headerViewMinHeight && !isExpanded {
            constraintHeightOfHeaderView.constant = headerViewMaxHeight
            constrainTopOfVideoTableView.constant = 20.0
            nameLabel.text = " "
            profileDataStackView.isHidden = false
            headerView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.2549019608, blue: 0.9137254902, alpha: 1)
            isExpanded = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
         }
        
    }
    
}
