//
//  KKCustomToastViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 27/06/2021.
//

import Foundation
import UIKit

class KKCustomToastViewController: KKBaseViewController {
    
    struct CustomToastViewConstant {
        
        static let maximumAlertViewWidth = ScreenSize.width * 0.7
        static let descriptionFontSize = KKUtil.ConvertSizeByDensity(size: 16)
        static let imgToastTypeWidth = KKUtil.ConvertSizeByDensity(size: 30)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
    }
    
    convenience init(toastType: ToastType, msgDesc: String) {
        self.init()

        let alertMessageView = UIView()
        alertMessageView.clipsToBounds = true
        self.view.addSubview(alertMessageView)

        let imgToastType = UIImageView()
        imgToastType.contentMode = .scaleAspectFit
        if (toastType == .Success){
            imgToastType.image = UIImage(named: "ic_alert_success")
        } else {
            imgToastType.image = UIImage(named: "ic_alert_exclamation")
        }
        alertMessageView.addSubview(imgToastType)
        
        let alertSubtitle = UILabel()
        alertSubtitle.textAlignment = .center
        alertSubtitle.numberOfLines = 0
        alertMessageView.addSubview(alertSubtitle)
        
        let maximumLabelSize = CGSize(width: CustomToastViewConstant.maximumAlertViewWidth - (ConstantSize.paddingStandard * 3 + CustomToastViewConstant.imgToastTypeWidth), height: CGFloat.greatestFiniteMagnitude)

        let bodyAttributes: [NSAttributedString.Key: Any] = [
            .font            : UIFont.systemFont(ofSize: CustomToastViewConstant.descriptionFontSize),
            .foregroundColor : UIColor.spade_white_FFFFFF
        ]
        
        let attributedSubtitleString = NSMutableAttributedString(string: msgDesc, attributes:bodyAttributes)
        
        let expectedAlertSubtitleSize = KKUtil.getLabelSize(text: msgDesc,
                                                            maximumLabelSize: maximumLabelSize,
                                                            attributes: bodyAttributes)

        var height: CGFloat = 0.0
        if (expectedAlertSubtitleSize.height * 1.5 < CustomToastViewConstant.imgToastTypeWidth + ConstantSize.paddingStandard * 1.5) {
            height = CustomToastViewConstant.imgToastTypeWidth + ConstantSize.paddingStandard * 1.5
        } else {
            height = expectedAlertSubtitleSize.height * 1.5
        }

        alertMessageView.frame = CGRect(x: 0, y: 0, width: CustomToastViewConstant.maximumAlertViewWidth, height: height)
        alertMessageView.center = self.view.center
        
        let imgToastTypeY = (height - CustomToastViewConstant.imgToastTypeWidth) / 2
        imgToastType.frame = CGRect(x: ConstantSize.paddingStandard, y: imgToastTypeY, width: CustomToastViewConstant.imgToastTypeWidth, height: CustomToastViewConstant.imgToastTypeWidth)

        let startingPoint: CGFloat = ConstantSize.paddingStandard * 2 + CustomToastViewConstant.imgToastTypeWidth
        let alertSubtitleY = (height - expectedAlertSubtitleSize.height) / 2
        let alertSubtitleWidth = CustomToastViewConstant.maximumAlertViewWidth - startingPoint - ConstantSize.paddingStandard

        alertSubtitle.attributedText = attributedSubtitleString
        alertSubtitle.frame = CGRect(x: startingPoint, y: alertSubtitleY, width: alertSubtitleWidth, height: expectedAlertSubtitleSize.height)

        modalPresentationStyle = .custom
        transitioningDelegate = self
        
        setGradientBackground(view: alertMessageView)
    }
    
    func setGradientBackground(view: UIView){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(white: 0, alpha: 0).cgColor,
            UIColor(white: 0, alpha: 0.8).cgColor,
            UIColor(white: 0, alpha: 1).cgColor,
            UIColor(white: 0, alpha: 0.8).cgColor,
            UIColor(white: 0, alpha: 0).cgColor]
        gradientLayer.locations = [0, 0.15, 0.5, 0.85, 1]
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension KKCustomToastViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return KKAlertControllerPresentTransition(backgroundColor: UIColor.clear)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return KKAlertControllerDismissTransition(backgroundColor: UIColor.green)
    }
}
