//
//  KKCustomAlertViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 11/06/2021.
//

import UIKit

class KKCustomAlertViewController: UIViewController {
    
    struct CustomAlertViewConstant {
        
        static let maximumAlertViewWidth = CGFloat(285)
        static let alertViewBorderWidth = CGFloat(1)
        static let alertViewBtnWidth = CGFloat(100)
        static let alertViewBtnHeight = CGFloat(30)
        static let titleFontSize = CGFloat(20)
        static let descriptionFontSize = CGFloat(14)
        static let emailDescriptionFontSize = CGFloat(13)
        static let dismissButtonFontSize = CGFloat(15)
        static let textGapSize = CGFloat(2.5)
        static let dismissButtonSize = CGFloat(40)
        static let dismissImageSize = CGFloat(32)
    }
    
    var delegate : KKCustomAlertViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.85)
    }
    
    convenience init(title: String, body: String, buttonTitle: String, btnFunc: Selector = #selector(dismissBtnClicked)) {
        self.init()
        
        let maximumLabelSize = CGSize(width: CustomAlertViewConstant.maximumAlertViewWidth - ConstantSize.paddingStandard, height: CGFloat.greatestFiniteMagnitude)

        let alertMessageView = UIView()
        alertMessageView.backgroundColor = UIColor.spade_black_000000
        alertMessageView.layer.cornerRadius = ConstantSize.paddingSecondaryHalf
        alertMessageView.layer.borderWidth = CustomAlertViewConstant.alertViewBorderWidth
        alertMessageView.layer.borderColor = UIColor.spade_blue_5CB5DE.cgColor
        alertMessageView.clipsToBounds = true
        self.view.addSubview(alertMessageView)
        
        var height: CGFloat = ConstantSize.paddingStandard
    
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font            : UIFont.Neutra(.Titling, size: CustomAlertViewConstant.titleFontSize),
            .foregroundColor : UIColor.spade_white_FFFFFF
        ]

        let titleLabel = UILabel()
        titleLabel.attributedText = NSMutableAttributedString(string: title.uppercased(), attributes:titleAttributes)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: ConstantSize.paddingHalf, y: height, width: maximumLabelSize.width, height: UIFont.Neutra(.Titling, size: CustomAlertViewConstant.titleFontSize).lineHeight)
        alertMessageView.addSubview(titleLabel)
        
        if title.count != 0 {
            
            height = height + UIFont.Neutra(.Titling, size: CustomAlertViewConstant.titleFontSize).lineHeight + ConstantSize.paddingSecondary
        }

        let bodyAttributes: [NSAttributedString.Key: Any] = [
            .font            : UIFont.Futura(.Book, size: CustomAlertViewConstant.descriptionFontSize),
            .foregroundColor : UIColor.spade_white_FFFFFF
        ]
        
        let attributedSubtitleString = NSMutableAttributedString(string: body, attributes:bodyAttributes)
        
        let expectedAlertSubtitleSize = KKUtil.getLabelSize(text: body,
                                                            maximumLabelSize: maximumLabelSize,
                                                            attributes: bodyAttributes)

        let alertSubtitle = UILabel()
        alertSubtitle.attributedText = attributedSubtitleString
        alertSubtitle.textAlignment = .center
        alertSubtitle.numberOfLines = 0
        alertSubtitle.frame = CGRect(x: ConstantSize.paddingHalf, y: height, width: maximumLabelSize.width, height: expectedAlertSubtitleSize.height)
        alertMessageView.addSubview(alertSubtitle)

        height = height + expectedAlertSubtitleSize.height + ConstantSize.paddingSecondary
        
        let dismissBtn = UIButton.init()
        dismissBtn.setTitle(buttonTitle, for: .normal)
        dismissBtn.setTitleColor(.white, for: .normal)
        dismissBtn.titleLabel!.font = .Neutra(.Medium, size: CustomAlertViewConstant.dismissButtonFontSize)
        dismissBtn.backgroundColor = .spade_blue_5CB5DE
        dismissBtn.layer.cornerRadius = ConstantSize.paddingSecondaryHalf
        dismissBtn.clipsToBounds = true
        dismissBtn.frame = CGRect(x: CustomAlertViewConstant.maximumAlertViewWidth/2 - CustomAlertViewConstant.alertViewBtnWidth/2, y: height, width: CustomAlertViewConstant.alertViewBtnWidth, height: CustomAlertViewConstant.alertViewBtnHeight)
        alertMessageView.addSubview(dismissBtn)

        dismissBtn.addTarget(self, action: btnFunc, for: .touchUpInside)

        height = height + CustomAlertViewConstant.alertViewBtnHeight + ConstantSize.paddingStandard
        
        alertMessageView.frame = CGRect(x: 0, y: 0, width: CustomAlertViewConstant.maximumAlertViewWidth, height: height)
        alertMessageView.center = self.view.center
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    @objc func dismissBtnClicked() {
        
        self.dismiss(animated: true, completion:{
            
            self.delegate?.alertViewButtonDidPressed(self, 0)
        })
    }
}

extension KKCustomAlertViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return KKAlertControllerPresentTransition(backgroundColor: UIColor.black.withAlphaComponent(0.65))
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return KKAlertControllerDismissTransition(backgroundColor: UIColor.black.withAlphaComponent(0.65))
    }
}


protocol KKCustomAlertViewControllerDelegate {
    
    func alertViewButtonDidPressed(_ vc:KKCustomAlertViewController, _ index : Int)
}
