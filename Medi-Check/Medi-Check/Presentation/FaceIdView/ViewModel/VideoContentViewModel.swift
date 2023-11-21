//
//  VideoContentViewModel.swift
//  Aespa-iOS
//
//  Created by 이영빈 on 2023/06/07.
//

import Combine
import SwiftUI
import Foundation
import AVFoundation
import Aespa

class VideoContentViewModel: ObservableObject {
    let aespaSession: AespaSession
    
    var preview: some View {
        return aespaSession.interactivePreview()
        
        // Or you can give some options
//        let option = InteractivePreviewOption(enableShowingCrosshair: false)
//        return aespaSession.interactivePreview(option: option)
    }
    
    private var subscription = Set<AnyCancellable>()
    
    @Published var videoAlbumCover: Image?
    @Published var photoAlbumCover: Image?
    
    @Published var videoFiles: [VideoAsset] = []
    @Published var photoFiles: [PhotoAsset] = []
    
    init() {
        var option = AespaOption(albumName: "Aespa-Demo-App")
        self.aespaSession = Aespa.session(with: option)
        
        // Common setting
        aespaSession
            .focus(mode: .continuousAutoFocus)
            .changeMonitoring(enabled: true)
            .orientation(to: .portrait)
            .quality(to: .high)
            .position(to: .front)
            .custom(WideColorCameraTuner()) { result in
                if case .failure(let error) = result {
                    print("Error: ", error)
                }
            }
        
        // Photo-only setting
        aespaSession
            .flashMode(to: .on)
            .redEyeReduction(enabled: true)
        
        // Video-only setting
        aespaSession
            .mute()
            .stabilization(mode: .auto)
        
        // Prepare video album cover
        aespaSession.videoFilePublisher
            .receive(on: DispatchQueue.main)
            .map { result -> Image? in
                if case .success(let file) = result {
                    return file.thumbnailImage
                } else {
                    return nil
                }
            }
            .assign(to: \.videoAlbumCover, on: self)
            .store(in: &subscription)
        
        // Prepare photo album cover
        aespaSession.photoFilePublisher
            .receive(on: DispatchQueue.main)
            .map { result -> Image? in
                if case .success(let file) = result {
                    return file.thumbnailImage
                } else {
                    return nil
                }
            }
            .assign(to: \.photoAlbumCover, on: self)
            .store(in: &subscription)
    }
    
    func fetchVideoFiles() {
        // File fetching task can cause low reponsiveness when called from main thread
        Task(priority: .utility) {
            let fetchedFiles = await aespaSession.fetchVideoFiles()
            DispatchQueue.main.async { self.videoFiles = fetchedFiles }
        }
    }
    
    func fetchPhotoFiles() {
        // File fetching task can cause low reponsiveness when called from main thread
        Task(priority: .utility) {
            let fetchedFiles = await aespaSession.fetchPhotoFiles()
            DispatchQueue.main.async { self.photoFiles = fetchedFiles }
        }
    }
    
    // 비디오 회전 (잘 작동함)
    func rotateVideo(videoURL: URL, completion: @escaping (URL?) -> Void) {
        let asset = AVAsset(url: videoURL)
        guard let clipVideoTrack = asset.tracks(withMediaType: .video).first else {
            completion(nil)
            return
        }

        let composition = AVMutableComposition()
        let compositionClipVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        try? compositionClipVideoTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: clipVideoTrack, at: CMTime.zero)
        
        let transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        compositionClipVideoTrack?.preferredTransform = transform

        guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
            completion(nil)
            return
        }

        let outputFileURL = URL(fileURLWithPath: NSTemporaryDirectory() + UUID().uuidString + ".mov")
        exporter.outputURL = outputFileURL
        exporter.outputFileType = .mov
        exporter.exportAsynchronously {
            switch exporter.status {
            case .completed:
                completion(outputFileURL)
            default:
                completion(nil)
            }
        }
    }
}


extension VideoContentViewModel {
    // Example for using custom session tuner
    struct WideColorCameraTuner: AespaSessionTuning {
        func tune<T>(_ session: T) throws where T : AespaCoreSessionRepresentable {
            session.avCaptureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        }
    }
}
