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
#define kMargin 5.0

@interface TravelAudioVolumeView()
{
    CGFloat _lineHeight;
}
@property (nonatomic, strong) UIColor  *defaultColor;
@end

@implementation TravelAudioVolumeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tinkColor    = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        self.bgColor      = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9/1.0];
        self.defaultColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1/1.0];
        
        _lineHeight = 1.0f / [UIScreen mainScreen].scale * 2;
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
            [self p_showVolumeView];
            /// code ...
            float volume = [[userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
            if (self.travel_volumeChangeBlock) {
                self.travel_volumeChangeBlock(volume);
            }
            [self setProgress:volume];
        }
    }
}

- (void)p_showVolumeView {
    
    __weakSelf(self);
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = weakSelf.frame;
        rect.origin.y = 0;
        [weakSelf setFrame:rect];
        
        [[weakSelf class] cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(p_hiddenVolumeView) object:nil];
        [weakSelf performSelector:@selector(p_hiddenVolumeView) withObject:nil afterDelay:1.6];
    }];
}

- (void)p_hiddenVolumeView {
    
    __weakSelf(self);
    [UIView animateWithDuration:0.6 animations:^{
        CGRect rect = weakSelf.frame;
        rect.origin.y = -10;
        [weakSelf setFrame:rect];
    }];
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
    CGContextFillRect(context, self.bounds);
    
    CGRect rc = self.bounds;
    // Drawing BgLine
    [self drawDefaultLineWithRect:rc context:context];
    
    CGFloat prsWith = self.bounds.size.width-2*kMargin;
    CGRectOffset(rc, -prsWith * (1 - self.progress), 0);
    rc.size.width = prsWith * self.progress;
    [self drawProgessWithRect:rc context:context];
}

/// 绘制默认line
- (void)drawDefaultLineWithRect:(CGRect)rect context:(CGContextRef)context {

    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, _lineHeight);
    CGContextBeginPath(context);
    [_defaultColor setFill];
    CGRect rc = CGRectMake(kMargin, (2*kMargin-_lineHeight)/2.0, rect.size.width-2*kMargin, _lineHeight);
    CGContextFillRect(context, rc);
    CGContextClosePath(context);// 路径结束标志，不写默认封闭
    CGContextDrawPath(context, kCGPathFill);//绘制路径path
}

/// 绘制Progress
- (void)drawProgessWithRect:(CGRect)rect context:(CGContextRef)context{
    
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, _lineHeight);
    CGContextBeginPath(context);
    [_tinkColor setFill];
    CGRect rc = CGRectMake(kMargin, (2*kMargin-_lineHeight)/2.0, rect.size.width, _lineHeight);
    CGContextFillRect(context, rc);
    CGContextClosePath(context);// 路径结束标志，不写默认封闭
    CGContextDrawPath(context, kCGPathFill);//绘制路径path
}

@end
