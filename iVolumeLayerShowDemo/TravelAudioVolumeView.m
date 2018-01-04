//
//  TravelAudioVolumeView.m
//  iVolumeLayerShowDemo
//
//  Created by ShawnWong on 2017/12/29.
//  Copyright © 2017年 ShawnWong. All rights reserved.
//

#import "TravelAudioVolumeView.h"
#import <AVFoundation/AVFoundation.h>

#define kTravelVolumeNotification @"AVSystemController_SystemVolumeDidChangeNotification"

@implementation TravelAudioVolumeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tinkColor = [UIColor redColor];
        self.bgColor = [UIColor greenColor];
        [self initAudioSession];
    }
    return self;
}

- (void)initAudioSession {
    
    NSError *error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(travelVolumeChanged:) name:kTravelVolumeNotification object:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void)travelVolumeChanged:(NSNotification *)notification {

    if ([notification.name isEqualToString:kTravelVolumeNotification]) {
        NSDictionary *userInfo = [notification userInfo];
        
        NSString *audioCategory = [userInfo objectForKey:@"AVSystemController_AudioCategoryNotificationParameter"];
        NSString *audioVolumeChangeReason = [userInfo objectForKey:@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"];
        if (([audioCategory isEqualToString:@"Audio/Video"] || [audioCategory isEqualToString:@"Ringtone"])
            && ([audioVolumeChangeReason isEqualToString:@"ExplicitVolumeChange"]))
        {
            /// code ...
            float volume = [[userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
            if (self.travel_volumeChangeBlock) {
                self.travel_volumeChangeBlock(volume);
            }
            [self setProgress:volume];
        }
    }
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_bgColor set];
    
    CGRect rc;
    CGContextFillRect(context, self.bounds);
    rc = self.bounds;
    CGRectOffset(rc, -self.bounds.size.width * (1 - self.progress), 0);
    rc.size.width = self.bounds.size.width * self.progress;
    
    [self drawProgessWithRect:rc];
}

/// Progress
- (void)drawProgessWithRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_tinkColor set];
    CGContextFillRect(context, rect);
    CGContextStrokePath(context);
    /// Animation
}

@end
