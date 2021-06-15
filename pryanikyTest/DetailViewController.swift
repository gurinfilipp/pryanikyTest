//
//  DetailViewController.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private var text: String
    private var imageURL: String?
    private let label = UILabel()
    private let logoImageView = UIImageView()
    
    init(title: String, text: String, imageURL: String?) {
        self.text = text
        if imageURL != nil {
            self.imageURL = imageURL
        }
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextField()
        guard let imageURL = self.imageURL else { return }
        setupLogoImageView(with: imageURL)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        logoImageView.pin.hCenter().vCenter().width(250).height(250)
        label.pin.hCenter().vCenter(-300).width(view.bounds.width).sizeToFit(.width)
    }
    
    func setupTextField() {
        view.addSubview(label)
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        label.text = self.text
    }
    
    func setupLogoImageView(with url: String) {
        view.addSubview(logoImageView)
        logoImageView.kf.setImage(with: URL(string: url))
    }
    
}
