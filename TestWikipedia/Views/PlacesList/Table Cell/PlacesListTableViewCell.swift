//
//  PlacesListTableViewCell.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 29.10.2023.
//

import UIKit
import TinyConstraints

final class PlacesListTableViewCell: UITableViewCell {

    static let nib = "PlacesListTableViewCell"
    static let reuseIdentifier = "PlacesListTableViewCellIdentifier"
    
    // MARK: - UI Properties
    
    private lazy var coloredView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(hex: 0xEDF5F8)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        return view
    }()
    
    fileprivate lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                nameLabel,
                locationStack
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    
    private lazy var nameLabel : UILabel = {
        var lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lbl.numberOfLines = 2
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var latitudeLabel : UILabel = {
        var lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    private lazy var longitudeLabel : UILabel = {
        var lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    private lazy var locationLableStack: UIStackView = {
        var stackView = UIStackView(
            arrangedSubviews: [
                latitudeLabel,
                longitudeLabel
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(frame: contentView.bounds)
        imageView.image =  #imageLiteral(resourceName: "icon.location").withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var locationStack: UIStackView = {
        var stackView = UIStackView(
            arrangedSubviews: [
                iconView,
                locationLableStack
            ]
        )
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = .clear
        

        iconView.width(24)
        iconView.height(24)
        
        return stackView
    }()
    
    // MARK: - inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.addSubview(self.coloredView)
        self.coloredView.addSubview(self.stackViewMain)
       
      
        self.setUpLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure cell
    func configure(with cellModel: PlaceObject){
        
        self.nameLabel.text = cellModel.fullnameStr
        self.longitudeLabel.text = cellModel.longitudeStr
        self.latitudeLabel.text = cellModel.latitudeStr
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel.text = nil
        
    }
    
}

// MARK: - UI extension
extension PlacesListTableViewCell {
     
    func setUpLayout(){
        self.coloredView.edgesToSuperview(
            insets: TinyEdgeInsets(
                top: 8,
                left: 20,
                bottom: 8,
                right: 20
            )
        )
        
        self.stackViewMain.edgesToSuperview(
            insets: TinyEdgeInsets(
                top: 20,
                left: 20,
                bottom: 20,
                right: 20
            )
        )
  
    }
}
