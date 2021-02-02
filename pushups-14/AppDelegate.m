//
//  AppDelegate.m
//  pushups-14
//
//  Created by liuwanwei on 2021/1/26.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#ifdef DEBUG
    [self _test];
#endif
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)_test{
    NSDate * from, * to;
    NSDate * now = [NSDate date];
    NSLog(@"now time for NSDate object: %@", now);
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSLog(@"now time with default time zone: %@", [formatter stringFromDate:now]);
    
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSLog(@"now time with local time zone: %@", [formatter stringFromDate:now]);
    
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSLog(@"now time with system time zone: %@", [formatter stringFromDate:now]);
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger week = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:[NSDate date]];
    NSLog(@"今天是今年的第 %@ 天", @(week));

    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSLog(@"本月有 %@ 天", @(range.length));
}

@end
