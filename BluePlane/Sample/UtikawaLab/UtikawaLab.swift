//
//  UtikawaLab.swift
//  BluePlane
//
//  Created by 原田龍青 on 2019/12/26.
//  Copyright © 2019 原田龍青. All rights reserved.
//

import UIKit
import RealityKit
import SceneKit
import ARKit
import AVFoundation
import CoreBluetooth

class UtikawaLab: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    //シーンビューとOutlet接続
    @IBOutlet weak var sceneView: ARSCNView!
    
    //矢印Nodeを追加
    lazy var yajirusiNode: SCNNode = {
        let scene = SCNScene(named: "art.scnassets/yajirusi.scn")!
        let node = scene.rootNode.childNode(withName: "yajirusi", recursively: true)!
        node.name = "yajirusiNode"
        
        node.scale = SCNVector3(x: 0.2, y: 0.2, z: 0.2)
        /*
         node.rotation = SCNVector4(x: 1,
                                   y: 0,
                                   z: 0,
                                   w: -.pi )
         */
        //node.position = SCNVector3(2, 0.5, 0)
        return node
    }()
    //誘導用Nodeを追加
    lazy var yudoNode: SCNNode = {
        let scene = SCNScene(named: "art.scnassets/yudo.scn")!
        let node = scene.rootNode.childNode(withName: "yudo", recursively: true)!
        node.name = "yudoNode"
        
        //node.scale = SCNVector3(x: 0.3, y: 0.3, z: 0.3)
        //node.rotation = SCNVector4(x: 0,y: 1,z: 0,w: -.pi / 4)
        //node.position = SCNVector3(-1, -1, 0)
        return node
    }()
    //目的地Nodeを追加
    lazy var targetNode: SCNNode = {
        let scene = SCNScene(named: "art.scnassets/target.scn")!
        let node = scene.rootNode.childNode(withName: "target", recursively: true)!
        node.name = "targetNode"
        
        //node.scale = SCNVector3(x: 0.3, y: 0.3, z: 0.3)
        //node.rotation = SCNVector4(x: 0,y: 1,z: 0,w: -.pi / 4)
        //node.position = SCNVector3(-1, -1, 0)
        return node
    }()
    
    //トラッキングするイメージを設定
    let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    //コンフィギュレーションの生成
      //  let configuration = ARImageTrackingConfiguration()
        //configuration.trackingImages = referenceImages!
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        //空間から光の情報を取得し画面上のライトの情報に適応
        configuration.isLightEstimationEnabled = true
    //セッションの開始
        sceneView.session.run(configuration)

    }

        //ビュー非表示時に呼ばれる
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            //セッションの一時停止
            sceneView.session.pause()
        }
    }

extension UtikawaLab: AVAudioPlayerDelegate {
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return}
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            // 音声の再生
            audioPlayer.play()
        } catch {
        }
    }
}

    extension UtikawaLab: ARSCNViewDelegate {
        
        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
            guard let lightEstimate = self.sceneView.session.currentFrame?.lightEstimate else { return }
            let ambientIntensity = lightEstimate.ambientIntensity
            let ambientColorTemperature = lightEstimate.ambientColorTemperature

            if let lightNode = self.sceneView.scene.rootNode.childNode(withName: "light", recursively: true) {
                guard let light = lightNode.light else { return }
                light.intensity = ambientIntensity
                light.temperature = ambientColorTemperature
            }
            
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
  //          targetNode.isHidden = false
            
            //ライトを追加する
             let light = SCNLight()
             light.type = .area
             
             let LightNode = SCNNode()
             LightNode.light = light
             LightNode.name = "light"
             LightNode.position = SCNVector3(-1,2,-1)
             sceneView.scene.rootNode.addChildNode(LightNode)
            
            if anchor.name == "jiji" {
                let textNode = TextNode(text: "Jiji")
                node.addChildNode(textNode)
                
                yajirusiNode.rotation = SCNVector4(x: 1,y: 0,z: 0,w: -.pi)
                yajirusiNode.position = SCNVector3(-4.5,-1,1)
                sceneView.scene.rootNode.addChildNode(yajirusiNode)
                
                
             //   targetNode.position = SCNVector3(0,0,0)
             //   sceneView.scene.rootNode.addChildNode(targetNode)
                print("anchor is added")
                
                /*
                //10秒後に処理(今回はNodeの消去)を開始
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
                    print("10秒経過")
                    self.yajirusiNode.removeFromParentNode()
                }
                 */
            }
            if anchor.name == "swiftbook" {
                let textNode = TextNode(text: "Swiftbook")
                node.addChildNode(textNode)
                yudoNode.position = SCNVector3(-3.8,-1.5,-3.5)
                
                sceneView.scene.rootNode.addChildNode(yudoNode)

                print("anchor is added")
                }
            if anchor.name == "Watches" {
                let textNode = TextNode(text: "Watches")
                node.addChildNode(textNode)
                print("anchor is added")
            }
            if anchor.name == "TokudaLab",anchor.name == "TokudaLab2" {
                let textNode = TextNode(text: "徳田研")
                node.addChildNode(textNode)
                //音源ファイルを再生
                playSound(name: "pointset")
                
                yudoNode.position = SCNVector3(0,-1,0)
                sceneView.scene.rootNode.addChildNode(targetNode)
                print("anchor is added")
            }
            if anchor.name == "Boken2" {
                let textNode = TextNode(text: "Gool")
                node.addChildNode(textNode)
                print("anchor is added")
            }
/*
            if (anchor.name == "FujimotoLab")||(anchor.name == "FujimotoLab2") {
                let textNode = TextNode(text: "藤本研")
                node.addChildNode(textNode)
                print("anchor is added")
            }
 */
            if (anchor.name == "KatunoLab")||(anchor.name == "KatunoLab2") {
                let textNode = TextNode(text: "勝野研")
                node.addChildNode(textNode)
                print("anchor is added")
            }
            if (anchor.name == "OtukaLab")||(anchor.name == "OtukaLab2") {
                let textNode = TextNode(text: "大塚研")
                node.addChildNode(textNode)
                print("anchor is added")
            }
            if (anchor.name == "UchikawaLab")||(anchor.name == "UchikawaLab2") {
                let textNode = TextNode(text: "内川研")
                node.addChildNode(textNode)
                //音源ファイルを再生
                playSound(name: "wiiclick")
                
                print("anchor is added")
            }
            if (anchor.name == "UchikawaLab")||(anchor.name == "KanouLab") {
                let textNode = TextNode(text: "狩野研")
                node.addChildNode(textNode)
                print("anchor is added")
            }

            if (anchor.name == "TukijiLab")||(anchor.name == "TukijiLab2") {
                let textNode = TextNode(text: "築地研")
                node.addChildNode(textNode)
                print("anchor is added")
            }
            
            if anchor.name == "BackPoint" {
                let textNode = TextNode(text: "引き返せ")
                node.addChildNode(textNode)
                //音源ファイルを再生
                playSound(name: "warning")

                print("anchor is added")
            }
        }
    }
