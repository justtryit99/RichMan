//
//  ImageExtension.swift
//  Parttime
//
//  Created by hsiang on 2017/10/27.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import UIKit

//extension UIImage {
//    /**
//     *  重設圖片大小
//     */
//    func reSizeImage(reSize:CGSize)->UIImage {
//        //UIGraphicsBeginImageContext(reSize);
//        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
//        self.draw(in: CGRect(x:0, y:0, width:reSize.width, height:reSize.height));
//        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
//        UIGraphicsEndImageContext();
//        return reSizeImage;
//    }
//
//    /**
//     *  等比率縮放
//     */
//    func scaleImage(scaleSize:CGFloat)->UIImage {
//        let reSize = CGSize(width:self.size.width * scaleSize, height:self.size.height * scaleSize)
//        return reSizeImage(reSize: reSize)
//    }
//}

extension UIImage {
    //圖片截圓形
    var circle: UIImage {
        let square = size.width < size.height ? CGSize(width:size.width, height:size.width) : CGSize(width:size.height, height:size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x:0, y:0), size:square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    //顏色轉圖片
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect:CGRect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    // 重設圖片大小
    func reSizeImage(reSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        
        if let reSizeImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return reSizeImage
        } else {
            return self
        }
    }
    
}

extension UIImageView {
    func resizeImage() {
        guard let image = self.image else {return}
        let width: CGFloat = 1000
        let height = width * image.size.height / image.size.width
        self.image = self.image?.reSizeImage(reSize: CGSize(width: width, height: height))
    }
}

// new imageView class
class CircleIMGView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        self.toCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.toCircle()
    }
}









