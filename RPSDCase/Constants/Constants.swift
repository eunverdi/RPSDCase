//
//  Constants.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 2.06.2023.
//

import Foundation

enum MainTabBarControllersTitle: String {
    case RecordedListController = "Videos"
    case CameraController = "Camera"
    case PlayerStatusController = "Player Status"
}

enum CellRowHeight: CGFloat {
    case RecordedListCellRowHeight = 80.0
    case PlayerStatusListCellRowHeight = 200.0
}

enum NotificationNames: String {
    case UserShotInformationNotificationName = "UserShotInformationNotification"
    case VideoDataNotificationName = "VideoDataNotification"
}
