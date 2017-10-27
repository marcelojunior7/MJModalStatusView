//
//  MJModalStatusView.swift
//  MJModalStatusView
//
//  Created by Marcelo Junior on 26/10/17.
//  Copyright © 2017 Marcelo Junior. All rights reserved.
//

import Foundation

public class MJModalStatusView: UIView {
    
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var subheadLabel: UILabel!
    
    let nibName = "MJModalStatusView"
    var contentView: UIView!
    var timer: Timer?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
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
    
    public override func layoutSubviews() {
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
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(3.0), target: self, selector: #selector(self.removeSelf), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func removeSelf() {
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

extension MJModalStatusView {
    public func set(image: UIImage) {
        self.imageStatus.image = image
    }
    
    public func set(headline text: String) {
        self.headlineLabel.text = text
    }
    
    public func set(subheading text: String) {
        self.subheadLabel.text = text
    }
    
    public func show(inView: UIView, headline: String, subheading: String, statusImage: UIImage) {
        inView.addSubview(self)
        set(image: statusImage)
        set(headline: headline)
        set(subheading: subheading)
    }
}
