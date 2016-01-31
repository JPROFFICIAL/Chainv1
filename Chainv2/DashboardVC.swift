//
//  MainCameraVC.swift
//  Chainv2
//
//  Created by Jordan Olson on 1/13/16.
//  Copyright © 2016 JPRODUCTION. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SCRecorder

class DashboardVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var VisualCameraPreview: UIImageView!
    
    @IBOutlet weak var flashToggleBtn: UIButton!
    @IBOutlet weak var cameraOrientationBtn: UIButton!
    @IBOutlet weak var sendToEditorBtn: UIButton!
    @IBOutlet weak var deleteChainBtn: UIButton!
    @IBOutlet var sendChainBtn: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var videoRecorder = SCRecorder()
    var recordSession = SCRecordSession()
    var videoPlayer = SCPlayer()
    
    var videoPlayerLayer = AVPlayerLayer()
    //TRYING
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    var didTakeVisual = Bool()
    
    
    

    var chainList: ChainListVC! = ChainListVC(nibName: "ChainListVC", bundle: nil)
    
    var linksList: LinksVC! = LinksVC(nibName: "LinksVC", bundle: nil)
    
    var cameraVC: CameraVC! = CameraVC(nibName: "CameraVC", bundle: nil)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeCamera = UISwipeGestureRecognizer(target: self, action: "swipeSwitchCamera:")
        swipeCamera.direction = .Up
        cameraView.addGestureRecognizer(swipeCamera)
        
        let startChain = UILongPressGestureRecognizer(target: self, action: "takeVideoChain:")
        startChain.minimumPressDuration = 0.1
        cameraView.addGestureRecognizer(startChain)
        
        sendToEditorBtn.hidden = true
        deleteChainBtn.hidden = true
        sendChainBtn.hidden = true
        
        let recorderDelegate = videoRecorder.delegate.self
        
        videoRecorder.videoConfiguration.scalingMode = AVVideoScalingModeResizeAspectFill
        videoRecorder.captureSessionPreset = AVCaptureSessionPresetHigh
        videoRecorder.device = AVCaptureDevicePosition.Back
        videoRecorder.maxRecordDuration = CMTimeMake(10, 1)
        
        videoRecorder.delegate = recorderDelegate
        
        
        
        
        
        videoRecorder.session = recordSession
        
 
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
        
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        videoRecorder.startRunning()
        
        videoRecorder.previewView = cameraView

    }
    @IBAction func toggleCameraOrientationPressed(sender: AnyObject) {
        
        switchCameraOrientation()
    }
    
    @IBAction func toggleFlashBtnPressed(sender: AnyObject) {
        
        
    }
    
    @IBAction func sendChainToEditor(sender: AnyObject) {
        playRecordedVideo()
        
    }
        
    @IBAction func deleteChainBtnPressed(sender: AnyObject) {
        
        videoPlayer.pause()
        recordSession.removeAllSegments(true)
        deleteChainBtn.hidden = true
        cameraView.hidden = false
        sendToEditorBtn.hidden = true
        flashToggleBtn.hidden = false
        cameraOrientationBtn.hidden = false

        
    }
    
    func swipeSwitchCamera(sender: UISwipeGestureRecognizer) {
        
        
        switchCameraOrientation()
        print("Swipe Recognized")
        
    }
    
    func switchCameraOrientation() {
        
        videoRecorder.switchCaptureDevices()

    }
    
    
    func takeVideoChain(sender: UILongPressGestureRecognizer) {
        
        
        
        if sender.state == .Began {
            
            if videoRecorder.videoEnabledAndReady == true && videoRecorder.audioEnabledAndReady == true {

            videoRecorder.record()
            sendToEditorBtn.hidden = false
                
            }
        }
        
        if sender.state == UIGestureRecognizerState.Ended {
        
            videoRecorder.pause()
            
        }
        
        
    }
    @IBAction func sendChainBtnPressed(sender: AnyObject) {
        
        saveVideoToCameraRoll()
    }
    
    
    func playRecordedVideo() {
        
        sendChainBtn.hidden = false
        deleteChainBtn.hidden = false
        cameraView.hidden = true
        sendToEditorBtn.hidden = true
        flashToggleBtn.hidden = true
        cameraOrientationBtn.hidden = true
        
        videoPlayer.setItemByAsset(recordSession.assetRepresentingSegments())
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(videoPlayerLayer)
        videoPlayer.loopEnabled = true
        videoPlayer.play()
        let duration = recordSession.duration
        print(duration)
        let asset = recordSession.assetRepresentingSegments()
        let segment = [recordSession.segments.first]
        
    }
    
    func saveVideoToCameraRoll() {
        
        let asset = recordSession.assetRepresentingSegments()
        let assetExportSession: SCAssetExportSession = SCAssetExportSession(asset: asset)
        assetExportSession.outputUrl = recordSession.outputUrl
        print(recordSession.outputUrl)
        assetExportSession.outputFileType = AVFileTypeMPEG4
        assetExportSession.exportAsynchronouslyWithCompletionHandler { () -> Void in
            if assetExportSession.error == nil {
                
                print("We got our Video file!")
                
            } else {
                
                print("Something Went wrong")
                
            }
            
            
        }
        
    }
    

}

