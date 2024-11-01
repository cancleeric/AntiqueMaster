//
//  EnumColors.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/26.
//

//import SpriteKit
import UIKit
import SwiftUI

let lightBlue = UIColor(red: 92/255, green: 188/255, blue: 245/255, alpha: 1.0)
//let lightBlue = Color(red: 92/255, green: 188/255, blue: 245/255)
let creamColor =  UIColor(red: 235/255, green: 235/255, blue: 210/255, alpha: 1)
let lightOrange = UIColor(red: 230/255, green: 110/255, blue: 89/255, alpha: 1.0)

let lightGreen = UIColor(red: 130/255, green: 251/255, blue: 155/255, alpha: 1.0)
let lightYellow = UIColor(red: 226/255, green: 172/255, blue: 70/255, alpha: 1.0)

let orangeYellow = UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1.0)
let lightYellow2 = UIColor(red: 255/255, green: 252/255, blue: 121/255, alpha: 1.0)

let darkBrownColor = UIColor(red: 102/255, green: 75/255, blue: 48/255, alpha: 1.0)
let darkBrownColor2 = UIColor(red: 89/255, green: 60/255, blue: 35/255, alpha: 1.0)


enum LeaderboardColors {
    case panelNodeBackground
    case listRowBackground

    
    var color: UIColor {
        switch self {
        case .panelNodeBackground:
            return UIColor(Color("PanelNodeBackground"))
        case .listRowBackground:
            return UIColor(Color("ListRowBackground"))
//        case .ScrollNodeBackground:
//            return UIColor(Color("ScrollNodeBackground"))
        }
    }
}

//enum UserListItemColors {
//
//}


//
enum Colors {
    case ReadyRewardBoardBorderColor
    case  WoodenBoardColor
    case  ReadyRewardBoardColor
    case CheckmarkBackgroundColor
    case TaskDescriptionColor
    
    case CollectButtonBackgroundColor
    case CollectButtonHeightColor
    case CollectButtonHighlightColor
    case CollectButtonShadowColor
    
    case ReadyRewardBorderColor
    case UnReadyRewardFillColor
    case ReadyRewardFillColor
    
    case ProductSubscriptionBannerBackgroundColor
    case ProductSubscriptionBannerBoardColor
    case DailySpecialsBackgroundColor
    case DailySpecialsBoardColor
    case ProductGoldBannerBoardColor
    case ProductGoldBannerBackgroundColor
    // MainMenuColor
//    case ExperienceLevelColor
//    case ExperienceLevelBoardColor
    case FriendInviteButtonBackgroundColor
    case FriendInviteButtonHeightColor
    case FriendInviteButtonHighlightColor
    case FriendInviteButtonShadowColor
    
    
    case UserListCoinsBackgroundColor
    case UserListCoinsBottomHeightColor
    case UserListCoinsHighlightColor
    case UserListCoinsTopHeightColor
    case UserListCoinsColor
    
    case ScrollNodeBackground
    case ListPageNodeBackground
    
    case UserListItemBackgroundColor
    case UserListItemHeightColor
    case UserListItemHighlightColor
    case UserListItemShadowColor
    
    case ScoreRectColor
    case CoinSwitcherBoardColor
    
    case lightBlue
    
    case StoreFontColor
    case StoreFontBoardColor
    case ProductRectBackgroundColor
    case ProductRectBackgroundBoardColor
    case ProductRectColor
    case ProductRectBoardColor
    
    case ButtonGreen
    case ButtonGreenDark
    case ButtonRed
    case ButtonRedDark
    case ButtonBlock
    case ButtonBlockDark
    
    case ButtonBlue
    case ButtonBlueDark
    
    case ButtonOrange
    case ButtonOrangeDark
    case ButtonPurple
    case ButtonPurpleDark
    case ButtonYellow
    case ButtonYellowDark
    
    case FontBrown
    case FontColorBrownBack
    
    case FontColorWhite
    case FontColorWhiteBack
    case FontColorDisabledTextColor
    case FontColorDisabledTextColorBack
    
    case FontColorDarkBrown
    case FontColorDarkBrownBack
    
    // PointGap
    case Number35TextColor
    case PanelBorderColor
    case PanelBorderShadowColor
    case PanelColor
    case PanelOverallShadowColor
    case ProgressBarColor
    case PtGapTextColor
    case Star1xBoardColor
    case Star1xColor
    case Star2xBoardColor
    case Star2xColor
    
    //  PercentageBarNode
    case ExperienceLevelBackgroundColor
    case ExperienceLevelBackgroundDarkColor
    case ExperienceLevelColor
    case ExperienceLevelBoardColor
    
    //
    case Player1HeadRectColor
    case Player2HeadRectColor
    case PlayerHeadBoardColor
    
    var color: Color {
        switch self {
        case .lightBlue:
            return Color(uiColor: UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0))
            
        case
                .ReadyRewardBoardBorderColor,
                .WoodenBoardColor,
                .ReadyRewardBoardColor,
                .CheckmarkBackgroundColor,
                .TaskDescriptionColor,
                .CollectButtonBackgroundColor,
                .CollectButtonHeightColor,
                .CollectButtonHighlightColor,
                .CollectButtonShadowColor,
                .ReadyRewardBorderColor,
                .ReadyRewardFillColor,
                .UnReadyRewardFillColor,
                .ProductSubscriptionBannerBoardColor,
                .ProductSubscriptionBannerBackgroundColor,
                .DailySpecialsBackgroundColor,
                .DailySpecialsBoardColor,
                .ProductGoldBannerBoardColor,
                .ProductGoldBannerBackgroundColor,
                .FriendInviteButtonBackgroundColor,
                .FriendInviteButtonHeightColor,
                .FriendInviteButtonHighlightColor,
                .FriendInviteButtonShadowColor,
                .ListPageNodeBackground,
                .ScrollNodeBackground,
                .UserListCoinsColor,
                .UserListCoinsBackgroundColor,
                .UserListCoinsBottomHeightColor,
                .UserListCoinsHighlightColor,
                .UserListCoinsTopHeightColor,
                .UserListItemBackgroundColor,
                .UserListItemHeightColor,
                .UserListItemHighlightColor,
                .UserListItemShadowColor,
                .ScoreRectColor,
                .CoinSwitcherBoardColor,
                .Player1HeadRectColor,
                .Player2HeadRectColor,
                .PlayerHeadBoardColor,
//                .ExperienceLevelColor,
//                .ExperienceLevelBoardColor,
                .Number35TextColor,
                .PanelBorderColor,
                .PanelBorderShadowColor,
                .PanelColor,
                .PanelOverallShadowColor,
                .ProgressBarColor,
                .PtGapTextColor,
                .Star1xBoardColor,
                .Star1xColor,
                .Star2xBoardColor,
                .Star2xColor,
            
                .ExperienceLevelBackgroundColor,
                .ExperienceLevelBackgroundDarkColor,
                .ExperienceLevelColor,
                .ExperienceLevelBoardColor,
            
                .StoreFontColor,
                .StoreFontBoardColor,
                .ProductRectBackgroundColor,
                .ProductRectBackgroundBoardColor,
                .ProductRectColor,
                .ProductRectBoardColor,
                .ButtonGreen,
                .ButtonGreenDark,
                .ButtonRed,
                .ButtonRedDark,
                .ButtonPurple,
                .ButtonPurpleDark,
                .ButtonBlock,
                .ButtonBlockDark,
                .ButtonBlue,
                .ButtonBlueDark,
                .ButtonOrange,
                .ButtonOrangeDark,
                .ButtonYellow,
                .ButtonYellowDark,
                .FontBrown,
                .FontColorBrownBack,
                .FontColorWhite,
                .FontColorWhiteBack,
                .FontColorDisabledTextColor,
                .FontColorDisabledTextColorBack,
                .FontColorDarkBrown,
                .FontColorDarkBrownBack:
            return Color(uiColor: self.uiColor)
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .lightBlue:
            return UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
        case
                .ReadyRewardBoardBorderColor,
                .WoodenBoardColor,
                .ReadyRewardBoardColor,
                .CheckmarkBackgroundColor,
                .TaskDescriptionColor,
                .CollectButtonBackgroundColor,
                .CollectButtonHeightColor,
                .CollectButtonHighlightColor,
                .CollectButtonShadowColor,
                .ReadyRewardBorderColor,
                .ReadyRewardFillColor,
                .UnReadyRewardFillColor,
                .ProductSubscriptionBannerBoardColor,
                .ProductSubscriptionBannerBackgroundColor,
                .DailySpecialsBackgroundColor,
                .DailySpecialsBoardColor,
                .ProductGoldBannerBoardColor,
                .ProductGoldBannerBackgroundColor,
                .FriendInviteButtonBackgroundColor,
                .FriendInviteButtonHeightColor,
                .FriendInviteButtonHighlightColor,
                .FriendInviteButtonShadowColor,
                .ListPageNodeBackground,
                .ScrollNodeBackground,
                .UserListCoinsColor,
                .UserListCoinsBackgroundColor,
                .UserListCoinsBottomHeightColor,
                .UserListCoinsHighlightColor,
                .UserListCoinsTopHeightColor,
                .UserListItemBackgroundColor,
                .UserListItemHeightColor,
                .UserListItemHighlightColor,
                .UserListItemShadowColor,
                .ScoreRectColor,
                .CoinSwitcherBoardColor,
                .Player1HeadRectColor,
                .Player2HeadRectColor,
                .PlayerHeadBoardColor,
//                .ExperienceLevelColor,
//                        .ExperienceLevelBoardColor,
                .ExperienceLevelBackgroundColor,
                .ExperienceLevelBackgroundDarkColor,
                .ExperienceLevelColor,
                .ExperienceLevelBoardColor,
            
                .Number35TextColor,
                .PanelBorderColor,
                .PanelBorderShadowColor,
                .PanelColor,
                .PanelOverallShadowColor,
                .ProgressBarColor,
                .PtGapTextColor,
                .Star1xBoardColor,
                .Star1xColor,
                .Star2xBoardColor,
                .Star2xColor,
            
                .StoreFontColor,
                .StoreFontBoardColor,
                .ProductRectBackgroundColor,
                .ProductRectBackgroundBoardColor,
                .ProductRectColor,
                .ProductRectBoardColor,
                .ButtonGreen,
                .ButtonGreenDark,
                .ButtonRed,
                .ButtonRedDark,
                .ButtonPurple,
                .ButtonPurpleDark,
                .ButtonBlock,
                .ButtonBlockDark,
                .ButtonBlue,
                .ButtonBlueDark,
                .ButtonOrange,
                .ButtonOrangeDark,
                .ButtonYellow,
                .ButtonYellowDark,
                .FontBrown,
                .FontColorBrownBack,
                .FontColorWhite,
                .FontColorWhiteBack,
                .FontColorDisabledTextColor,
                .FontColorDisabledTextColorBack,
                .FontColorDarkBrown,
                .FontColorDarkBrownBack:
            return UIColor(named: "\(self)") ?? UIColor.black
        }
    }
    
}

