//
//  MJModalStatusView.swift
//  MJModalStatusView
//
//  Created by Marcelo Junior on 26/10/17.
//  Copyright © 2017 Marcelo Junior. All rights reserved.
//

import Foundation

public class MJModalStatusView: UIView {
    
    @IBOutlet public weak var imageStatus: UIImageView!
    @IBOutlet public weak var headlineLabel: UILabel!
    @IBOutlet public weak var subheadLabel: UILabel!
    
    fileprivate let nibName = "MJModalStatusView"
    fileprivate var contentView: UIView!
    fileprivate var timer: Timer?
    fileprivate var duration: Double?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    fileprivate func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.alpha = 0.0
        
        headlineLabel.text = ""
        subheadLabel.text = ""
    }
    
    override public func layoutSubviews() {
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = .identity
        }) { _ in
            guard let duration = self.duration else { return }
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(duration), target: self, selector: #selector(self.removeSelf), userInfo: nil, repeats: false)
        }
    }
    
    @objc fileprivate func removeSelf() {
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

extension MJModalStatusView {
    fileprivate func set(image: UIImage) {
        self.imageStatus.image = image
    }
    
    fileprivate func set(headline text: String) {
        self.headlineLabel.text = text
    }
    
    fileprivate func set(subheading text: String) {
        self.subheadLabel.text = text
    }
    
    public func show(inView: UIView, headline: String, subheading: String, statusImage: UIImage, duration: Double? = 1.0) {
        inView.addSubview(self)
        self.duration = duration
        self.set(image: statusImage)
        self.set(headline: headline)
        self.set(subheading: subheading)
    }
}
