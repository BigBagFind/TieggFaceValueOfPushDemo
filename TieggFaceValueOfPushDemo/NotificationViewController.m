//
//  NotificationViewController.m
//  TieggFaceValueOfPushDemo
//
//  Created by 吴玉铁 on 15/11/13.
//  Copyright © 2015年 铁哥. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController


- (IBAction)sendNotification:(UIButton *)sender {
    NSLog(@"notBtn:%s",__FUNCTION__);
    [NotificationViewController registerLocalNotification:10];// 10秒后
    
    
    
}


+ (void)registerLocalNotification:(NSInteger)alertTime{
    
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    //设置触发通知时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    notification.fireDate = fireDate;
    //区时
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    // 通知内容
    notification.alertBody = @"Dear,Your FaceValue is 99.9 today!";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"Dear,Your FaceValue is 99.9 today!" forKey:@"key"];
    notification.userInfo = userDict;
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    }else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    
    
    
    
    
}



@end
