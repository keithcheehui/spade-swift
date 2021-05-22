//
//  KKBonusContentViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/05/2021.
//

import Foundation
import UIKit

class KKBonusContentViewController: KKBaseViewController {
    
    @IBOutlet weak var lblContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        lblContent.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id enim dolor. Nunc faucibus semper nulla, et aliquet nibh tincidunt nec. Duis vitae sem rhoncus, bibendum ante a, elementum dui. Ut ornare consequat magna ac blandit. Ut enim lorem, laoreet vel ipsum ut, tristique tempus mauris. Nulla interdum nulla id est tincidunt, et porta libero suscipit. Quisque convallis felis id lectus ultrices accumsan. Ut ultrices dignissim eros, nec lacinia elit bibendum eget. Cras aliquam arcu et lobortis malesuada. Pellentesque odio libero, feugiat vitae lectus at, lacinia placerat quam. Fusce eget faucibus eros. Donec sed pellentesque elit. Nulla facilisi. Fusce nec porttitor quam, at pharetra nisi. Proin quis tortor vitae magna porta efficitur in eget nisi. Aenean non leo ac elit efficitur porttitor.\n\nFusce iaculis dapibus imperdiet. Mauris commodo feugiat sollicitudin. Proin malesuada sem at finibus tristique. Etiam a sem varius, volutpat lorem vel, bibendum ipsum. Proin massa quam, laoreet nec condimentum sed, pellentesque at dui. Morbi aliquam sit amet nunc nec porttitor. Donec viverra, odio ac luctus elementum, enim leo semper lorem, quis bibendum nisl libero id augue.\n\nCras gravida enim arcu, nec pretium leo aliquam a. Fusce iaculis sapien ultrices, maximus elit nec, consectetur est. In dignissim nulla vel orci luctus, in imperdiet nisi bibendum. Pellentesque venenatis sodales quam vitae condimentum. Phasellus varius ex vel hendrerit tempus. Mauris laoreet ex ac porttitor ultrices. Morbi laoreet, lacus non sagittis aliquam, erat lorem finibus lorem, eu ullamcorper augue purus maximus elit. Etiam et lacus vel quam laoreet varius sollicitudin ut nisi. Cras tincidunt leo et lectus suscipit, a volutpat erat fringilla. Fusce vulputate metus ipsum, vel gravida arcu fermentum ut."
        
        lblContent.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        
        lblContent.textColor = UIColor.spade_white_FFFFFF
    }
}
