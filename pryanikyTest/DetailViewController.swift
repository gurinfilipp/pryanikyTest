//
//  DetailViewController.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//

import UIKit

class DetailViewController: UIViewController {

    private var text: String
    private var imageURL: String?
    
    private let label = UILabel()
    private let logoImageView = UIImageView()
    
    init(text: String, imageURL: String?) {
        self.text = text
        if let imageUrl = imageURL {
            self.imageURL = imageURL
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTextField()
        
        //guard let imageURL = self.imageURL else { return }
        //setupImageView(with: imageURL!)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    func setupLayout() { // pin only
        //imageView.pin.vCenter(120).hCenter().width(200).height(200).sizeToFit()
     //   logoImageView.pin.all()
        label.pin.hCenter().vCenter(-300).width(view.bounds.width).sizeToFit(.width)
    }

    func setupTextField() {
        view.addSubview(label)
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
      //  textField.textColor = .white
        label.backgroundColor = .orange
        label.text = self.text
    }
    
    func setupImageView(with url: String) {
        view.addSubview(logoImageView)
        logoImageView.backgroundColor = .orange
        logoImageView.contentMode = .scaleAspectFit
        
        NetworkManager.fetchImage(url: self.imageURL ?? "") { (image) in
            self.logoImageView.image = image
        }
        
        
        
    }
    
}
