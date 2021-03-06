//
//  WRCycleCell.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit
import Kingfisher

open class WRCycleCell: UICollectionViewCell
{
    //=======================================================
    // MARK: 对外提供的属性
    //=======================================================
    open var imgSource:ImgSource = ImgSource.LOCAL(name: "placeholder")  {
        didSet {
            switch imgSource {
            case let .SERVER(url):
                imgView.kf.setImage(with: url)
            case let .LOCAL(name):
                imgView.image = UIImage(named: name)
            }
        }
    }
    
    open var placeholderImage: UIImage?
    
    open var descText:String? {
        didSet {
            descLabel.isHidden  = (descText == nil) ? true : false
            bottomView.isHidden = (descText == nil) ? true : false
            descLabel.text = descText
        }
    }
    
    override open var frame: CGRect {
        didSet {
            bounds.size = frame.size
        }
    }
    
    open var imageContentModel:UIViewContentMode = .scaleAspectFill {
        didSet {
            imgView.contentMode = imageContentModel
        }
    }
    
    open var descLabelFont: UIFont = UIFont(name: "Helvetica-Bold", size: 18)! {
        didSet {
            descLabel.font = descLabelFont
        }
    }
    open var descLabelTextColor: UIColor = UIColor.white {
        didSet {
            descLabel.textColor = descLabelTextColor
        }
    }
    open var descLabelHeight: CGFloat = 60 {
        didSet {
            descLabel.frame.size.height = descLabelHeight
        }
    }
    open var descLabelTextAlignment:NSTextAlignment = .left {
        didSet {
            descLabel.textAlignment = descLabelTextAlignment
        }
    }
    
    open var descLabelTop: CGFloat = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    
    open var imageViewHeight: CGFloat?{
        didSet{
            setNeedsLayout()
        }
    }
    
    open var bottomViewBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.5) {
        didSet {
            bottomView.backgroundColor = bottomViewBackgroundColor
        }
    }
    
    
    
    //=======================================================
    // MARK: 内部属性
    //=======================================================
    fileprivate var imgView:UIImageView!
    fileprivate var descLabel:UILabel!
    fileprivate var bottomView:UIView!
    
    //=======================================================
    // MARK: 构造方法
    //=======================================================
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupImgView()
        setupDescLabel()
        setupBottomView()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("WRCycleCell  deinit")
    }
    
    
    //=======================================================
    // MARK: 内部方法（layoutSubviews）
    //=======================================================
    override open func layoutSubviews()
    {
        super.layoutSubviews()
        
        imgView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: imageViewHeight ?? bounds.height)
        
        if let _ = descText
        {
            let margin:CGFloat = 16
            let labelWidth     = imgView.bounds.width - 2 * margin
            let labelHeight    = descLabelHeight
            let labelY         = imgView.frame.maxY - labelHeight
            descLabel.frame    = CGRect(x: margin, y: labelY + descLabelTop, width: labelWidth, height: labelHeight)
            bottomView.frame   = CGRect(x: 0, y: labelY + descLabelTop, width: imgView.bounds.width, height: labelHeight)
            bringSubview(toFront: descLabel)
        }
    }
}

//=======================================================
// MARK: - 基本控件（图片、描述文字、底部view）
//=======================================================
extension WRCycleCell
{
    fileprivate func setupImgView()
    {
        imgView = UIImageView()
        imgView.contentMode = imageContentModel
        imgView.clipsToBounds = true
        addSubview(imgView)
    }
    
    fileprivate func setupDescLabel()
    {
        descLabel = UILabel()
        descLabel.text = descText
        descLabel.numberOfLines = 0
        descLabel.font = descLabelFont
        descLabel.textColor = descLabelTextColor
        descLabel.frame.size.height = descLabelHeight
        descLabel.textAlignment = descLabelTextAlignment
        addSubview(descLabel)
        descLabel.isHidden = true
    }
    
    fileprivate func setupBottomView()
    {
        bottomView = UIView()
        bottomView.backgroundColor = bottomViewBackgroundColor
        addSubview(bottomView)
        bottomView.isHidden = true
    }
}

