//
//  CameraView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI
import RealityKit
import CoreML
import Vision
import SceneKit
import ARKit

struct CameraView: View {
    // MARK: - ATTRIBUTES
    var modelData: ModelData = .shared
    @State var viewAR = true
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            ARViewContainer(enableAR: $viewAR)
                .ignoresSafeArea()
            
            VStack {
                changeView()
                // Only shows information if something is recognized
                if modelData.IdentfiedWaste != "Not found" {
                    if viewAR {
                        WasteIdentDisplay()
                    } else {
                        WasteIdentDisplay2()
                    }
                }
            }
            
        }//: ZSTACK
    }
    
    // MARK: - CHANGE VIEW
    func changeView() -> some View {
        HStack {
            Button {
                viewAR.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThickMaterial)
                    .scaledToFit()
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: viewAR ? "arkit" : "arkit.badge.xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: viewAR ? 30 : 38)
                            .padding(.leading, viewAR ? 0 : 6)
                            .foregroundStyle(viewAR ? .accent : .gray)
                            .contentTransition(.symbolEffect(.replace))
                            .symbolRenderingMode(.multicolor)
                    }
            }
            .padding(.horizontal, 25)
            Spacer()
        }//: HSTACK
    }
}

// MARK: - GRAB FRAMES
func continuouslyUpdate() {
    let modelData: ModelData = .shared
    
    // access what we need from the observed object
    let v = modelData.ARview
    let sess = v.session
    let mod = modelData.model
    
    // access the current frame as an image
    let tempImage: CVPixelBuffer? = sess.currentFrame?.capturedImage
    
    //get the current camera frame from the live AR session
    if tempImage == nil {
        return
    }
    
    let tempciImage = CIImage(cvPixelBuffer: tempImage!)
    
    // create a reqeust to the Vision Core ML Model
    let request = VNCoreMLRequest(model: mod) { (request, error) in }
    
    //crop just the center of the captured camera frame to send to the ML model
    request.imageCropAndScaleOption = .centerCrop
    
    // perform the request
    let handler = VNImageRequestHandler(ciImage: tempciImage, orientation: .right)
    
    do {
        //send the request to the model
        try handler.perform([request])
    } catch {
        print(error)
    }
    
    guard let observations = request.results as? [VNClassificationObservation] else { return}
    
    // only proceed if the model prediction's confidence in the first result is greater than 90%
    modelData.IdentfiedWaste = "Not found"
    if observations[0].confidence < 0.7  { return }
    
    // the model returns predictions in descending order of confidence
    // we want to select the first prediction, which has the higest confidence
    let topLabelObservation = observations[0].identifier
    
    let firstWord = topLabelObservation.components(separatedBy: [","])[0]
        
    if modelData.IdentfiedWaste != firstWord {
        DispatchQueue.main.async {
            modelData.IdentfiedWaste = firstWord
        }
    }
}


#Preview {
    CameraView()
}
