//
// Created by Mikhail Maltsev on 18.09.17.
// Copyright (c) 2017 Moorka. All rights reserved.
//

import Foundation
import UIKit


open class MTImageSlider:UIView,UIScrollViewDelegate {
    var pages = [UIImageView]()
    public var urls:[String]?
    lazy var session = URLSession.shared
    
    var scroll:UIScrollView?
    var pageControl:UIPageControl?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.scroll = UIScrollView()
        self.scroll?.delegate = self
        self.pageControl = UIPageControl()
        self.pageControl?.currentPage = 0
        self.pageControl?.tintColor = UIColor.black
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cur_index:Int = Int(round(scrollView.contentOffset.x / self.frame.width))
        self.pageControl!.currentPage = cur_index
    }

    func imageLoad(index:Int) {
        let task = session.dataTask(with: URL(string: self.urls![index])!) {
            data, _ , err in
            guard data != nil && err == nil else {
                return
            }
            
            let image = UIImage(data: data!)
            UIGraphicsBeginImageContext(self.pages[0].frame.size)
            image?.draw(in: self.pages[0].bounds)
            let res:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            self.pages[index].image = res
        }
        task.resume()
    }


    func setUpView() {
        self.scroll!.frame = CGRect(origin: .zero, size: CGSize(width: self.frame.width, height: self.frame.height))

        self.scroll!.contentSize = CGSize( width: self.frame.width * CGFloat(self.urls!.count), height: self.frame.height)
        self.scroll!.contentOffset = CGPoint(x: 0, y: 0)
        self.scroll!.isPagingEnabled = true
        self.scroll!.isScrollEnabled = true
        self.scroll!.backgroundColor = UIColor.black
        self.addSubview(self.scroll!)
        
        self.pageControl!.center = CGPoint(x: self.center.x, y: self.frame.height - 10.0)
        self.addSubview(self.pageControl!)
        self.pageControl!.backgroundColor = UIColor.black
        self.pageControl!.size(forNumberOfPages: self.urls!.count)
        self.pageControl!.numberOfPages = self.urls!.count
        
        for i in 0..<self.urls!.count {
            let page = UIImageView(image: UIImage(color: .gray, size: CGSize(width: self.frame.width, height: self.frame.height)))
            page.frame = CGRect(x: self.frame.width  * CGFloat(i), y: 0, width: self.frame.width, height: self.frame.height)
            self.pages.append(page)
            self.scroll?.addSubview(page)
        }

        self.pageControl!.alpha = self.pages.count > 1 ? 1.0 : 0.0

    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.start()
    }
    
    
    open func start() {
        self.setUpView()
        
        for index in 0..<self.urls!.count {
            self.imageLoad(index: index)
        }
    }
}


public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
