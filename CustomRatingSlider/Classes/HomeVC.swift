//
//  HomeVC.swift
//  CustomRatingSlider
//
//  Created by Nirzar Gandhi on 23/06/25.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ratingContainer: UIView!
    
    @IBOutlet weak var gradientBg: UIImageView!
    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var niddleContainer: UIView!
    @IBOutlet weak var niddleImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var resetRatingBtn: UIButton!
    
    @IBOutlet weak var niddleContainerX: NSLayoutConstraint!
    @IBOutlet weak var resetRatingBtnBottom: NSLayoutConstraint!
    
    
    // MARK: -
    // MARK: - View init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.setControlsProperty()
        self.animateThumbToRating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    fileprivate func setControlsProperty() {
        
        self.view.backgroundColor = .white
        self.view.isOpaque = false
        
        // Rating Container View
        self.ratingContainer.backgroundColor = .black
        self.ratingContainer.addRadiusWithBorder(radius: 10.0)
        self.ratingContainer.clipsToBounds = true
        
        // Gradient Background
        self.gradientBg.backgroundColor = .clear
        self.gradientBg.addRadiusWithBorder(radius: 3.0)
        self.gradientBg.clipsToBounds = true
        self.gradientBg.contentMode = .scaleToFill
        self.gradientBg.image = UIImage(named: "RatingGradientBG")
        
        // Stackview
        self.stackview.backgroundColor = .clear
        self.stackview.axis = .horizontal
        self.stackview.alignment = .fill
        self.stackview.distribution = .equalSpacing
        self.stackview.spacing = 0.0
        
        // Labels
        self.label0.backgroundColor = .clear
        self.label0.textColor = .white
        self.label0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.label0.numberOfLines = 1
        self.label0.lineBreakMode = .byTruncatingTail
        self.label0.textAlignment = .left
        self.label0.text = "0"
        
        self.label1.backgroundColor = .clear
        self.label1.textColor = .white
        self.label1.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.label1.numberOfLines = 1
        self.label1.lineBreakMode = .byTruncatingTail
        self.label1.textAlignment = .center
        self.label1.text = "1"
        
        self.label2.backgroundColor = .clear
        self.label2.textColor = .white
        self.label2.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.label2.numberOfLines = 1
        self.label2.lineBreakMode = .byTruncatingTail
        self.label2.textAlignment = .center
        self.label2.text = "2"
        
        self.label3.backgroundColor = .clear
        self.label3.textColor = .white
        self.label3.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.label3.numberOfLines = 1
        self.label3.lineBreakMode = .byTruncatingTail
        self.label3.textAlignment = .center
        self.label3.text = "3"
        
        self.label4.backgroundColor = .clear
        self.label4.textColor = .white
        self.label4.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.label4.numberOfLines = 1
        self.label4.lineBreakMode = .byTruncatingTail
        self.label4.textAlignment = .center
        self.label4.text = "4"
        
        self.label5.backgroundColor = .clear
        self.label5.textColor = .white
        self.label5.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.label5.numberOfLines = 1
        self.label5.lineBreakMode = .byTruncatingTail
        self.label5.textAlignment = .right
        self.label5.text = "5"
        
        // Niddle Container
        self.niddleContainer.backgroundColor = .clear
        
        // Niddle Imageview
        self.niddleImage.backgroundColor = .clear
        self.niddleImage.contentMode = .scaleAspectFit
        self.niddleImage.image = UIImage(named: "TicketRatingNiddle")
        
        // Rating Label
        self.ratingLabel.backgroundColor = .clear
        self.ratingLabel.textColor = .white
        self.ratingLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        self.ratingLabel.numberOfLines = 1
        self.ratingLabel.textAlignment = .center
        self.ratingLabel.text = "0"
        
        // Reset Rating Buttton
        self.resetRatingBtn.setBackgroundColor(color: .black, forState: .normal)
        self.resetRatingBtn.setTitleColor(.white, for: .normal)
        self.resetRatingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        self.resetRatingBtn.titleLabel?.lineBreakMode = .byClipping
        self.resetRatingBtn.addRadiusWithBorder(radius: 10.0)
        self.resetRatingBtn.layer.masksToBounds = true
        self.resetRatingBtn.setTitle("Reset Rating", for: .normal)
        
        self.resetRatingBtnBottom.constant = UIDevice.current.hasNotch ? getBottomSafeAreaHeight() : 20
    }
}


// MARK: - Call back
extension HomeVC {
    
    fileprivate func generateRandomRating() -> Double {
        return Double.random(in: 0...5)
    }
    
    fileprivate func animateThumbToRating() {
        
        self.niddleContainerX.constant = 0
        self.niddleContainer.updateConstraints()
        
        let ratingPercentageValue = self.generateRandomRating()
        self.ratingLabel.text = ratingPercentageValue.withCommas(minFraction: 1, maxFraction: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            
            let width = SCREENWIDTH - 40 - 30
            let pointX = (ratingPercentageValue * width) / 5.0
            self.niddleContainerX.constant = 30.0 - self.niddleContainer.bounds.width + pointX
            
            UIView.animate(withDuration: 1.0) {
                self.ratingContainer.layoutIfNeeded()
            }
        }
    }
}


// MARK: - Button Touch & Action
extension HomeVC {
    
    @IBAction func resetRatingBtnTouch(_ sender: UIButton) {
        self.animateThumbToRating()
    }
}
