//
//  listSearchTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit
import Cosmos

// 관광지 검색한 후 -list 페이지
class ListSearchTouristSpotViewController: UIViewController {
    
    let array = ["  문화 역사  ","  이색거리  ","  식당  ","  자연  ","  둘레길  "]

    //gradient
    var gradientLayer: CAGradientLayer!
    
    //UIColor
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    
    @IBOutlet weak var 검색창맵있는뷰: UIView!
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var keyWordCollectionView: UICollectionView!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

    }
    @IBAction func onToggleBtnClicked(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapSearchTouristSpotViewController")
//        vc?.modalPresentationStyle = .overFullScreen
//        self.present(vc!, animated: false, completion: nil)
        dismiss(animated: false, completion: nil)
    }
    
    
    func setUI() {
        검색창맵있는뷰.setBorderShadow(borderWidth: 0, cornerRadius: 0, useShadowEffect: true, shadowRadius: 3.0)
       
        setTopGradationDesign()
    }
    // 상단 그라데이션 디자인
    func setTopGradationDesign() {
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = topDesignView.bounds
        self.gradientLayer.colors = [topDesignColor1 as Any,topDesignColor2 as Any]
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.topDesignView.layer.addSublayer(self.gradientLayer)

        self.topDesignView.bringSubviewToFront(topDesignLayoutView)
    }
}

extension ListSearchTouristSpotViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(keyWordCollectionView){
            return 5
        }else {
        return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.isEqual(keyWordCollectionView){
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchKeyWord", for: indexPath) as? searchKeyWordCollectionViewCell else {
            return UICollectionViewCell()}
      
        cell.setUI(title: array[indexPath.row])
        
        return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tourSpotContent", for: indexPath) as? tourSpotContentCollectionViewCell else {
                return UICollectionViewCell()}
            
            cell.setUI()
            
            return cell
        }
    }

}

extension ListSearchTouristSpotViewController:UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            if collectionView.isEqual(keyWordCollectionView){
            //width 세팅에 사용됨
            let maxSize = CGSize(width: 250, height: 250)
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //width
            let collectionViewCellWidth = NSString(string: array[indexPath.row]).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 17)], context: nil)
            //height
            let collectionViewCellHeight = collectionView.bounds.height
            return CGSize(width: collectionViewCellWidth.width, height: collectionViewCellHeight)
            }
            else {
                let width = view.bounds.width
                let height = collectionView.bounds.height
                return CGSize(width: (width/10)*9, height: height/6)
            }
        }
    
}

class tourSpotContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowBorderView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var describeTextView: UITextView!
    
    func setUI(){
        // 테스트용 내용. 설정 필요!
        titleLabel.text = "dd"
        ratings.rating = 3
        describeTextView.text = "ddddd"
        
        // 상위 뷰 흘러넘치는 그림자 허용 설정
        self.layer.masksToBounds = false
        self.contentView.layer.masksToBounds = false
        // 그림자 설정
        shadowBorderView.setBorderShadow(borderWidth: 0.5, cornerRadius: 5, useShadowEffect: true, shadowRadius: 2)
        
    }
   
}

//extension 영역

// 그림자 효과
extension UIView {
    func setBorderShadow(borderWidth : CGFloat,cornerRadius : CGFloat,borderColor : CGColor = UIColor.systemGray.cgColor, useShadowEffect boolean : Bool, shadowRadius : CGFloat){
        
        //테두리 설정
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        
        
        //테두리 그림자 효과 설정
        self.layer.masksToBounds = !boolean
        self.layer.shadowColor = UIColor.systemGray.cgColor // 그림자 색
        self.layer.shadowOffset = CGSize(width: 3, height: 3) // 그림자를 이동시키는 정도
        self.layer.shadowOpacity = 0.7 //그림자 투명도
        self.layer.shadowRadius = shadowRadius //그림자 경계의 선명도 숫자가 클수록 그림자가 많이 퍼진다.
    }
}

// layer -> 특정 부분만 선 추가
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
