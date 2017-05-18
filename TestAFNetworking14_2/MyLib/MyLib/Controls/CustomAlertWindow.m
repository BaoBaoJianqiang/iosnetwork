//
//  CustomAlertWindow.m
//  MyApp
//

#import "CustomAlertWindow.h"

#define LABEL_MARGIN      10       //Label的外边距
#define CENTER_Y_TO_EDGE  80       //悬浮窗中心点距边缘的纵坐标值

@implementation CustomAlertWindow

+ (instancetype)aletWindowWithPositionOption:(AlertWindowPositionOption)positionType andInfoText:(NSString *)text {
    return [[CustomAlertWindow alloc] initWithPositionOption:positionType andInfoText:text];
}

- (instancetype)initWithPositionOption:(AlertWindowPositionOption)positionType andInfoText:(NSString *)text {
    self = [super init];
    if (self) {
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 15)];
        infoLabel.text = text;
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.font = [UIFont systemFontOfSize:13];
        infoLabel.textColor = [UIColor whiteColor];
        //label尺寸适应文字大小
        [infoLabel sizeToFit];
        
        //根据labelSize确定window的大小
        CGSize labelSize = infoLabel.frame.size;
        CGSize windowSize = CGSizeMake(labelSize.width + 2*LABEL_MARGIN, labelSize.height + 2*LABEL_MARGIN);
        //根据window的尺寸确定label的中心点位置
        infoLabel.center = CGPointMake(windowSize.width / 2, windowSize.height / 2);
        
        //得到屏幕的尺寸
        CGRect superRect = [[UIScreen mainScreen] bounds];
        CGSize superSize = superRect.size;
        //计算window的大小
        self.frame = CGRectMake((superSize.width - windowSize.width) / 2, 0, windowSize.width, windowSize.height);
        
        //根据指定的positionType设置window的center
        switch (positionType) {
            case AlertWindowPositionTopMiddle:
                self.center = CGPointMake(superSize.width / 2, CENTER_Y_TO_EDGE);
                break;
                
            case AlertWindowPositionCenter:
                self.center = CGPointMake(superSize.width / 2, superSize.height / 2);
                break;
                
            case AlertWindowPositionBottomMiddle:
                self.center = CGPointMake(superSize.width / 2, superSize.height - CENTER_Y_TO_EDGE);
                break;
                
            default:
                break;
        }
        
        self.windowLevel = UIWindowLevelAlert + 1;
        self.backgroundColor = [UIColor colorWithRed:64  / 255.0 green:64 / 255.0 blue:64 / 255.0 alpha:0.7];
        self.layer.cornerRadius = 5;
        
        [self addSubview:infoLabel];
    }
    
    return self;
}

//显示window
- (void)show {
    [self makeKeyAndVisible];
}

//window消失
- (void)dismiss {
    [self resignKeyWindow];
}

@end
