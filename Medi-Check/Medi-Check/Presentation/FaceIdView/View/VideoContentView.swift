//
//  VideoContentView.swift
//  Aespa-iOS
//
//  Created by 이영빈 on 2023/06/07.
//

import Aespa
import SwiftUI

struct VideoContentView: View {
    @State var isRecording = false
    @State var isFront = false
    
    @State var showSetting = false
    @State var showGallery = false
    
    
    @State var captureMode: AssetType = .video
    @State private var rotationAngle: Double = 0
    
//    @Binding var goToFaceIdView: Bool
    @Binding var isSuccessFaceId: Bool
    @Binding var nickname: String
    
    @ObservedObject private var viewModel = VideoContentViewModel()
    @ObservedObject var faceIdViewModel = FaceIdViewModel()
    @EnvironmentObject var userData: UserData
    
    // 화면 회전은 잘 되는데, 영상이 제대로 안찍히는 오류 있음.
    private func adjustForOrientation() {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .landscapeRight:
            rotationAngle = 90
        case .landscapeLeft:
            rotationAngle = -90
        default:
            rotationAngle = 0
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            viewModel.preview
                .scaledToFit()
                .background(Color.red)
                .rotationEffect(.degrees(rotationAngle))
                .background(Color.gray)
            
            
            // Shutter + button
            recordingButtonShape(width: 60).onTapGesture {
                switch captureMode {
                case .video:
                    if isRecording {
                        viewModel.aespaSession.stopRecording()
                        isRecording = false
                    } else {
                        viewModel.aespaSession.stopRecording { result in
                            switch result {
                            case .success(let file):
                                print(file)
                                if let videoURL = file.path {
                                    do {
                                        print(videoURL.lastPathComponent)
                                        //                                        networkViewModel.uploadImage(imageData: file.thumbnail.jpegData(compressionQuality: 1.0)!, to: URL(string: "http://yuno.hopto.org:5000/upload")!) { _ in
                                        //                                            print("사진 성공")
                                        //                                        }
                                        
                                        let videoData = try Data(contentsOf: videoURL)
                                        faceIdViewModel.uploadVideo(videoData: videoData, to: URL(string: "http://yuno.hopto.org:5000/video")!) { _ in
                                        }
                                        //                                                networkViewModel.uploadVideo1(videoURL: file.path!, to: URL(string: "http://yuno.hopto.org:5000/video")!) { _ in
                                        //
                                        //                                                }
                                    } catch {
                                        print("비디오 데이터 로드 실패: \(error)")
                                    }
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                        isRecording = true
                    }
                case .photo:
                    viewModel.aespaSession.capturePhoto()
                }
            }
            
        }
        //        .sheet(isPresented: $showSetting) {
        //            SettingView(contentViewModel: viewModel)
        //        }
        //        .sheet(isPresented: $showGallery) {
        //            GalleryView(mediaType: $captureMode, contentViewModel: viewModel)
        //        }
        
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                adjustForOrientation()
            }
            adjustForOrientation()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.aespaSession.startRecording()
                isRecording = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    viewModel.aespaSession.stopRecording { result in
                        switch result {
                        case .success(let file):
                            print(file)
                            if let videoURL = file.path {
                                do {
                                    print(videoURL.lastPathComponent)
                                    let videoData = try Data(contentsOf: videoURL)
                                    if nickname == "" {
                                        faceIdViewModel.uploadVideo(videoData: videoData, to: URL(string: "http://yuno.hopto.org:5000/video")!) { _ in
                                            DispatchQueue.main.async {
                                                print(userData.members)
                                                userData.currnetProfile.nickName = faceIdViewModel.name
                                                print(userData.currnetProfile.nickName)
                                                let currentNickName = userData.currnetProfile.nickName
                                                if let matchedMember = userData.members.first(where: { $0.nickName == currentNickName }) {
                                                    userData.currnetProfile.profileImage = matchedMember.profileImage
                                                    userData.currnetProfile.familyCode = matchedMember.familyCode
                                                    userData.currnetProfile.nickName = matchedMember.nickName
                                                    print(userData.currnetProfile)
                                                }
    //                                            goToFaceIdView
                                                isSuccessFaceId = true
                                            }
                                        }
                                    } else {
                                        faceIdViewModel.uploadImage(nickname: nickname,imageData: file.thumbnail.jpegData(compressionQuality: 1.0)!, to: URL(string: "http://yuno.hopto.org:5000/upload")!) { _ in
                                            print("사진 성공")
                                        }
                                    }
                                    
                                    //                                    networkViewModel.uploadVideo1(videoURL: file.path!, to: URL(string: "http://yuno.hopto.org:5000/video")!) { _ in
                                    //                                    }
                                    
                                    
                                    
                                } catch {
                                    print("비디오 데이터 로드 실패: \(error)")
                                }
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    isRecording = false
                }
            }
        }
    }
}

extension VideoContentView {
    @ViewBuilder
    func roundRectangleShape(with image: Image, size: CGFloat) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size, alignment: .center)
            .clipped()
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 1)
            )
            .padding(20)
    }
    
    @ViewBuilder
    func recordingButtonShape(width: CGFloat) -> some View {
        ZStack {
            Circle()
                .strokeBorder(isRecording ? .red : .white, lineWidth: 3)
                .frame(width: width)
            
            Circle()
                .fill(isRecording ? .red : .white)
                .frame(width: width * 0.8)
        }
        .frame(height: width)
    }
}

enum AssetType {
    case video
    case photo
}

//#Preview {
//    VideoContentView()
//}
