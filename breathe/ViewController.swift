//
//  ViewController.swift
//  breathe
//
//  Created by Alvin Tu on 3/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    enum State {
//        case inhaleLeftNostril
//        case inhaleRightNostril
//        case exhaleLeftNostril
//        case exhaleRightNostril
        case inhaleBothNostrils
        case exhaleBothNostrils
        case inhaleMouth
        case exhaleMouth
    }
    


    @IBOutlet weak var leftNostril: UIView!
    @IBOutlet weak var mouth: UIView!
    @IBOutlet weak var rightNostril: UIView!
    
    @IBOutlet weak var leftMeter: UIView!
    @IBOutlet weak var rightMeter: UIView!
    @objc var emitterLayer1 = CAEmitterLayer()
    @objc var emitterLayer2 = CAEmitterLayer()
    @objc var emitterCell1 = CAEmitterCell()
    @objc var emitterCell2 = CAEmitterCell()


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEmitterCell()
        setUpEmitterLayer()
        flare(leftNostril)
        flare(rightNostril)
        scaleUpandDown(mouth)
        bringUpAndDown(leftMeter)
        bringUpAndDown(rightMeter)
        
        setUpEmitterPositions(for:.inhaleBothNostrils)


        // Do any additional setup after loading the view.
        
    }
    
    func bringUpAndDown(_ view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "position.y")
        animation.values = [225, 25, 25, 125, 175, 225, 225]
        animation.keyTimes = [0, 0.25,0.35, 0.6, 0.8, 0.9, 1]
        animation.duration = 8
//        count of 2-4 seconds and exhale for a count of 4-6
        animation.repeatCount = Float.infinity
        view.layer.add(animation, forKey: nil)

    }
    
    
    func scaleUpandDown(_ view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 2.0, 2.0, 1.65, 1.25, 1.00, 1.00]
        animation.keyTimes = [0, 0.25,0.35, 0.6, 0.8, 0.9, 1]
        animation.duration = 8
//        count of 2-4 seconds and exhale for a count of 4-6
        animation.repeatCount = Float.infinity
        view.layer.add(animation, forKey: nil)

    }
    
    
    func flare(_ view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.1, 1.0, 1.1, 1.0, 1.1, 1.0]
        animation.keyTimes = [0, 0.25,0.35, 0.6, 0.8, 0.9, 1]
        animation.duration = 4
//        count of 2-4 seconds and exhale for a count of 4-6
        animation.repeatCount = Float.infinity
        view.layer.add(animation, forKey: nil)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }


}


extension ViewController {
  func setUpEmitterLayer() {
    // 1
    resetEmitterCells()
    emitterLayer1.frame = view.bounds
    view.layer.addSublayer(emitterLayer1)

    // 2
    emitterLayer1.seed = UInt32(Date().timeIntervalSince1970)

    // 3
//    emitterLayer1.emitterPosition = CGPoint(x: view.bounds.midX * 1.5, y: view.bounds.midY)

    // 4
    emitterLayer1.renderMode = .additive
    
    
    emitterLayer2.frame = view.bounds
    view.layer.addSublayer(emitterLayer2)

    // 2
    emitterLayer2.seed = UInt32(Date().timeIntervalSince1970)

    // 3
//    emitterLayer2.emitterPosition = CGPoint(x: view.bounds.midX , y: view.bounds.midY)

    // 4
    emitterLayer2.renderMode = .additive

  }

  func setUpEmitterCell() {
    // 1
    emitterCell1.contents = UIImage(named: "bubble")?.cgImage

    // 2
    emitterCell1.velocity = 20.0
    emitterCell1.velocityRange = 20.0

    // 3
//    emitterCell1.color = UIColor.blue.cgColor

    // 4
//    emitterCell.redRange = 1.0
//    emitterCell.greenRange = 1.0
//    emitterCell.blueRange = 1.0
//    emitterCell.alphaRange = 0.0
//    emitterCell.redSpeed = 0.0
//    emitterCell.greenSpeed = 0.0
//    emitterCell.blueSpeed = 0.0
//    emitterCell.alphaSpeed = -0.5
//    emitterCell.scaleSpeed = 0.1

    // 5
    let zeroDegreeesInRadians = degreesToRadians(0)
    emitterCell1.spin = degreesToRadians(250.0)
    emitterCell1.spinRange = zeroDegreeesInRadians
    emitterCell1.emissionLatitude = zeroDegreeesInRadians
    emitterCell1.emissionLongitude = zeroDegreeesInRadians
    emitterCell1.emissionRange = degreesToRadians(0)

    // 6
    emitterCell1.lifetime = 0.6
    emitterCell1.birthRate = 10.0

    // 7
    emitterCell1.xAcceleration = 200
    emitterCell1.yAcceleration = -300
    
    
    emitterCell2.contents = UIImage(named: "bubble")?.cgImage

    // 2
    emitterCell2.velocity = 20.0
    emitterCell2.velocityRange = 20.0


    let zeroDegreesInRadians = degreesToRadians(0.0)
    emitterCell2.spin = degreesToRadians(130.0)
    emitterCell2.spinRange = zeroDegreesInRadians
    emitterCell2.emissionLatitude = zeroDegreesInRadians
    emitterCell2.emissionLongitude = zeroDegreesInRadians
    emitterCell2.emissionRange = degreesToRadians(360.0)

    // 6
    emitterCell2.lifetime = 0.6
    emitterCell2.birthRate = 10.0

    // 7
    emitterCell2.xAcceleration = -200
    emitterCell2.yAcceleration = -300

  }

  func resetEmitterCells() {
    emitterLayer1.emitterCells = nil
    emitterLayer1.emitterCells = [emitterCell1]
    
    
    emitterLayer2.emitterCells = nil
    emitterLayer2.emitterCells = [emitterCell2]

  }
    
    
    func setUpEmitterPositions(for state: State){
        
        switch state {
        case .exhaleBothNostrils:

            emitterLayer1.emitterPosition = CGPoint(x: leftNostril.frame.midX, y: leftNostril.frame.maxY + 250)
            emitterLayer2.emitterPosition = CGPoint(x: rightNostril.frame.midX + 100, y: rightNostril.frame.maxY + 250)
            setUpAccelerationDirection(state: .exhaleBothNostrils)

        case .inhaleBothNostrils:

            emitterLayer1.emitterPosition = CGPoint(x: leftNostril.frame.midX, y: leftNostril.frame.maxY + 250)
            emitterLayer2.emitterPosition = CGPoint(x: rightNostril.frame.midX + 100, y: rightNostril.frame.maxY + 250)
            setUpAccelerationDirection(state: .inhaleBothNostrils)


        case .exhaleMouth:
            emitterLayer1.emitterPosition = CGPoint(x: mouth.frame.midX, y: mouth.frame.maxY + 100)
            emitterLayer2.emitterPosition = CGPoint(x: mouth.frame.midX + 100, y: mouth.frame.maxY + 100 )
            setUpAccelerationDirection(state: .exhaleMouth)


        case .inhaleMouth:
            emitterLayer1.emitterPosition = CGPoint(x: mouth.frame.midX, y: mouth.frame.maxY + 250)
            emitterLayer2.emitterPosition = CGPoint(x: mouth.frame.midX + 100, y: mouth.frame.maxY + 250)
            setUpAccelerationDirection(state: .inhaleMouth)


        }
        
        }
    
    private func  setUpAccelerationDirection(state: State){
        switch state {
        case .exhaleBothNostrils:
            emitterCell1.xAcceleration = 200
            emitterCell1.yAcceleration = -300
            
            emitterCell2.xAcceleration = -200
            emitterCell2.yAcceleration = -300

        case .inhaleBothNostrils:
            emitterCell1.xAcceleration = 200
            emitterCell1.yAcceleration = -300
            
            emitterCell2.xAcceleration = -200
            emitterCell2.yAcceleration = -300


        case .exhaleMouth:
            emitterCell1.xAcceleration = -200
            emitterCell1.yAcceleration = 500
            emitterCell2.xAcceleration = 200
            emitterCell2.yAcceleration = 500


        case .inhaleMouth:
            emitterCell1.xAcceleration = 200
            emitterCell1.yAcceleration = -300
            
            emitterCell2.xAcceleration = -200
            emitterCell2.yAcceleration = -300
            
        }
    

    }
    
    func degreesToRadians(_ degrees: Double) -> CGFloat {
      return CGFloat(degrees * Double.pi / 180.0)
    }

    func radiansToDegrees(_ radians: Double) -> CGFloat {
      return CGFloat(radians / Double.pi * 180.0)
    }
}


extension ViewController {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    if let location = touches.first?.location(in: view) {
//      emitterLayer1.emitterPosition = location
//    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//    if let location = touches.first?.location(in: view) {
//      emitterLayer1.emitterPosition = location
//    }

  }
}
