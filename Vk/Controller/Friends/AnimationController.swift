//
//  AnimationController.swift
//  Ninth_homework_task
//
//  Created by Nihad on 11/24/20.
//

import UIKit

class AnimationController: NSObject {
    private let animationDuration: Double
    private let animationType: AnimationType
    
    enum AnimationType {
        case push
        case pop
    }
    
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }
}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        switch animationType {
        case .push:
            transitionContext.containerView.addSubview(fromView)
            transitionContext.containerView.addSubview(toView)
            presentAnimation(with: transitionContext, fromView: fromView, toView: toView)
        case .pop:
            transitionContext.containerView.addSubview(fromView)
            transitionContext.containerView.addSubview(toView)
            dismissAnimation(with: transitionContext, fromView: fromView, toView: toView)
        }
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView) {
        fromView.setAnchorPoint(CGPoint(x: 0, y: 0))
        toView.setAnchorPoint(CGPoint(x: 0, y: 0))

        toView.transform = CGAffineTransform(rotationAngle: -.pi/2)

        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, animations: {
            fromView.transform = CGAffineTransform(rotationAngle: .pi/2)
            toView.transform = CGAffineTransform.identity
        }) { _ in
            fromView.transform = CGAffineTransform.identity
            transitionContext.completeTransition(true)
        }
    }
    
    func dismissAnimation(with transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView) {
        fromView.setAnchorPoint(CGPoint(x: 0, y: 0))
        toView.setAnchorPoint(CGPoint(x: 0, y: 0))
        
        toView.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            fromView.transform = CGAffineTransform(rotationAngle: -.pi/2)
            toView.transform = CGAffineTransform.identity
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}

