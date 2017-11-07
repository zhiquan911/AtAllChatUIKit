//
//  SCMessage.swift
//  Pods
//
//  Created by 麦志泉 on 15/9/1.
//
//

import Foundation
import UIKit
import AVFoundation
import IGListKit

/**
消息媒体类型

- Text:          文本
- Photo:         图像
- Video:         视频
- Voice:         语音
- Emotion:       表情
- LocalPosition: 地理位置
*/
public enum ATMessageItemType {
    case text, photo, video, voice
    //, Emotion, LocalPosition
}

public enum ATMessageItemSourceType: Int {
    case send, receive
}

public class ATMessageItem: NSObject {
    
    /// 消息唯一ID
    public var messageId = ""
    
    /// 文本内容
    public var text: String = ""
    
    //消息发送者的头像
    public var avatar: UIImage?
    //头像地址
    public var avatarUrl: String = ""
    //发送者的id
    public var senderId: String = ""
    //发送者的名字
    public var senderName: String = ""
    
    //发送时间
    public var timestamp: Int64 = 0
    
    //是否显示用户名字
    public var shouldShowUserName: Bool = true
    
    //是否发送了
    public var sended: Bool = false
    
    //是否出错
    public var isError: Bool = false
    
    //错误信息
    public var error: String = ""
    
    //消息来源类型
    public var messageSourceType: ATMessageItemSourceType = .send
    
    //消息媒体类型
    public var messageMediaType: ATMessageItemType = .text
    
    //是否已读
    public var isRead: Bool = false
    
    /// 消息附件
    public var attachment: ATMessageAttachment?
    
    /************ 语音相关 ************/
    public var voicePath: String!
    public var voiceUrl: String!
    public var voiceDuration: String!
    
    /************ 图像相关 ************/
    public var photo: UIImage!
    public var thumbnailPhoto: UIImage!
    public var thumbnailUrl: String!
    public var originPhotoUrl: String!
//    var originPhotoPath: String! {
//        didSet {
//            let file = SCConstants.photoFileFolder.URLByAppendingPathComponent(self.originPhotoPath)
//            let image = UIImage(contentsOfFile: file.path!)
//            self.thumbnailPhoto = image
//            self.photo = image
//        }
//    }
    
    /************ 视频相关 ************/
    var videoPath: String!
    var videoUrl: String!
    var videoDuration: String!
    
//    convenience init(videoPath: String) {
//        self.init()
//        self.messageMediaType = SCMessageMediaType.Video
//        self.videoPath = videoPath
//        self.setThumbnailPhotoByVideoPath(self.videoPath)
//    }
//
//    func setThumbnailPhotoByVideoPath(videoPath: String) {
//        var newImage: UIImage?
//        do {
//            let asset = AVURLAsset(URL: SCConstants.videoFileFolder.URLByAppendingPathComponent(self.videoPath))
//            let assetImageGenerator = AVAssetImageGenerator(asset: asset)
//            assetImageGenerator.appliesPreferredTrackTransform = true
//            assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels
//
//            let thumbnailImageRef: CGImageRef
//            let thumbnailImageTime: Int64  = 0;
//
//            thumbnailImageRef = try assetImageGenerator.copyCGImageAtTime(CMTimeMake(thumbnailImageTime, 60), actualTime: nil)
//
//            newImage = UIImage(CGImage: thumbnailImageRef)
//        } catch let error as NSError  {
//            NSLog("setThumbnailPhotoByVideoPath error: \(error)")
//        }
//        if newImage != nil {
//            self.thumbnailPhoto =  newImage
//        }
//    }
    
}


// MARK: - 实现模型的主键
extension ATMessageItem: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.messageId as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
    
}


/// 消息附件
public class ATMessageAttachment {
    
    
    /// 文件名
    public var filename: String = ""
    
    /// 文件常规下载路径
    public var fileurl: String = ""
    
    /// 缩略图路径
    public var thumbnailurl: String = ""
    
    /// 源文件下载路径
    public var originurl: String = ""
    
    /// 文件大小
    public var fileSize: Int64 = 0
    
    /// 时长
    public var duration: Int64 = 0
    
    /// 格式
    public var format: String = ""

}
