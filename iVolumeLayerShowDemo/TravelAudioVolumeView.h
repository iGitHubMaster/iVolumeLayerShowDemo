//
//  TravelAudioVolumeView.h
//  iVolumeLayerShowDemo
//
//  Created by ShawnWong on 2017/12/29.
//  Copyright © 2017年 ShawnWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelAudioVolumeView : UIView

/*
/// 使用说明
#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TravelAudioVolumeView.h"

@interface ViewController ()

@property (nonatomic, strong) TravelAudioVolumeView *volumeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initVolumeLayer];
    [self initVolumeProgressBar];
}

- (void) initVolumeLayer {
    
    /// 替换系统音量展示view
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
    volumeView.center = CGPointMake(-300, -300); // 设置中心点，让音量视图不显示在屏幕中 100 * 100
    [volumeView sizeToFit];
    [volumeView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:volumeView];
}

- (void)initVolumeProgressBar {
    
    [self.volumeView setFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    [self.view addSubview:self.volumeView];
    self.volumeView.travel_volumeChangeBlock = ^(CGFloat progress) {
        NSLog(@"%f", progress);
    };
}

#pragma mark - Lazy
- (TravelAudioVolumeView *)volumeView {
    if (!_volumeView) {
        _volumeView = [[TravelAudioVolumeView alloc] initWithFrame:CGRectZero];
    }
    return _volumeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

*/


/// currentVolume
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UIColor  *tinkColor;

@property (nonatomic, strong) UIColor  *bgColor;

@property (nonatomic, copy) void(^travel_volumeChangeBlock)(CGFloat);

@end
