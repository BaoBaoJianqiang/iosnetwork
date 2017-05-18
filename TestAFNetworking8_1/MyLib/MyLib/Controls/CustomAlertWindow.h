//
//  CustomAlertWindow.h
//  MyApp
//
//  参考文章：http://www.jianshu.com/p/e31eeb26cdce

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AlertWindowPositionOption) {
    AlertWindowPositionTopMiddle = 0,
    AlertWindowPositionCenter,
    AlertWindowPositionBottomMiddle
};

@interface CustomAlertWindow : UIWindow
+ (instancetype)aletWindowWithPositionOption:(AlertWindowPositionOption)positionType andInfoText:(NSString *)text;
//显示
- (void)show;
// 消失
- (void)dismiss;
@end
