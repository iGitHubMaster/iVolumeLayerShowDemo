//
//  TravelAudioVolumeView.h
//  iVolumeLayerShowDemo
//
//  Created by ShawnWong on 2017/12/29.
//  Copyright © 2017年 ShawnWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelAudioVolumeView : UIView

/// currentVolume
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UIColor  *tinkColor;

@property (nonatomic, strong) UIColor  *bgColor;

@property (nonatomic, copy) void(^travel_volumeChangeBlock)(CGFloat);

@end
