//
//  KKSplashScreenViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 27/04/2021.
//

import UIKit

class KKSplashScreenViewController: KKBaseViewController {

    @IBOutlet weak var loadingBar: UIView!
    @IBOutlet weak var imgBgloadingBar: UIImageView!
    @IBOutlet weak var lblLoading: UILabel!
    
    @IBOutlet weak var imgLogoWidth: NSLayoutConstraint!
    @IBOutlet weak var loadingBarHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingBarMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var loadingBarMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblLoadingMarginBottom: NSLayoutConstraint!
    
    var imgProgress: UIImageView!
    var progressValue: CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        drawLoadingProgress()
    }

    func initialLayout(){
        imgLogoWidth.constant = KKUtil.ConvertSizeByDensity(size: 480)
        loadingBarHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        loadingBarMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 130)
        loadingBarMarginRight.constant = loadingBarMarginLeft.constant
        lblLoadingMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
    }

    func drawLoadingProgress(){
        
        imgProgress = UIImageView.init()
        imgProgress.image = UIImage(named: "bg_loading_bar")
        imgProgress.contentMode = .scaleToFill
        imgProgress.clipsToBounds = true
        imgProgress.frame = CGRect(x: 1, y: 0.25, width: 0, height: loadingBar.bounds.height - 6)
        loadingBar.addSubview(imgProgress)
        
        self.perform(#selector(updateProgress), with: nil, afterDelay: 0.1)
    }
    
    @objc func updateProgress() {
        
        progressValue = progressValue + 0.1
        self.imgProgress.frame.size.width = self.loadingBar.bounds.width * progressValue

        if progressValue < 0.9 {
            
            lblLoading.text = String.init(format: "loading %.0f%%...", progressValue*100)
            self.perform(#selector(updateProgress), with: nil, afterDelay: 0.1)
        }
        else
        {
            lblLoading.text = "loading 100%..."
            self.present(KKSelectCountryViewController(), animated: false, completion: nil)
        }
    }
}
