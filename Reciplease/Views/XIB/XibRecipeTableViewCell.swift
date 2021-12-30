//
//  XibRecipeTableViewCell.swift
//  Reciplease
//
//  Created by SEBASTIEN BRUNET on 22/12/2021.
//

import UIKit

/// This class defines a view to be used
/// as a factorized cell view in a search result
/// view controller.
class XibRecipeTableViewCell: UIView {

    // - MARK: RECIPE OBJECT
    
    /// This var receives a recipe object whenever
    /// a cell is created, and sets up sub views once
    /// self changes value.
    var recipe: Hit! {
        didSet {
            recipeName.text = recipe.recipe.label
            ingredientsListLabel.text = recipe.recipe.ingredientLines.joined(separator: ", ")
            if let cookingTime = recipe.recipe.totalTime, cookingTime != 0.0 {
                cookingTimeLabel.text = "🕓 \(Int(cookingTime)) mn"
            } else {
                cookingTimeLabel.text = "🕓 N/A"
            }
            if let likes = recipe.recipe.yield {
                numberOfLIkesLabel.text = "🏆 \(likes)"
            } else {
                numberOfLIkesLabel.text = "👍 N/A"
            }
            guard let imageURL = recipe.recipe.image else {
                let image = UIImage(imageLiteralResourceName: "default_hamburger")
                recipeImage.image = image
                return
            }
            guard let url = URL(string: imageURL) else {
                let image = UIImage(imageLiteralResourceName: "default_hamburger")
                recipeImage.image = image
                return
            }
            addGradient()
            recipeImage.af.setImage(withURL: url)
        }
    }

    // - MARK: OUTLETS
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var contentVIew: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var greyview: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var numberOfLIkesLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    
    // - MARK: INITS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // - MARK: FUNCTIONS
    
    /// This function is called at cell build,
    /// either done in storyboard or code
    /// in inits above.
    private func commonInit() {
        Bundle.main.loadNibNamed("XibRecipeTableViewCell", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        makeRoundCornersToLikeAndCookingViews()
    }

    /// This function makes round corners to top left
    /// subview displaying cooking time and rating.
    private func makeRoundCornersToLikeAndCookingViews() {
        greyview.layer.cornerRadius = 10
        blackView.layer.cornerRadius = 10
    }

    /// This function adds a clear to black gradient to recipe image
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: frame.height)
        gradientLayer.type = .axial
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor,
                                UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        recipeImage.layer.addSublayer(gradientLayer)
    }

}
