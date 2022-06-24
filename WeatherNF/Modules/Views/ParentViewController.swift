//
//  ParentViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import UIKit

protocol SendSearch: AnyObject {
    func searchAction(_ go: String)
}

class ParentViewController: UIViewController {

    weak var sendAction: SendSearch?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        setBackButton()
        setupSearchButton()
    }
    fileprivate func setBackButton() {
        let backButtonItem = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backButtonItem
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
    }
    
    fileprivate func setupSearchButton() {
        let searchButton = UIButton(type: .system)
        searchButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        searchButton.setImage(UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let serchItem = UIBarButtonItem(customView: searchButton)
        let currWidt = serchItem.customView?.widthAnchor.constraint(equalToConstant: 40)
        currWidt?.isActive = true
        let currHeight = serchItem.customView?.heightAnchor.constraint(equalToConstant: 40)
        currHeight?.isActive = true
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = serchItem
        searchButton.addTarget(self, action: #selector(sendSearch), for: .touchUpInside)
    }
    
    @objc fileprivate func sendSearch() {
        self.sendAction?.searchAction("go")
    }


}
