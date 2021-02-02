//
//  Schedule.h
//  pushups-14
//
//  Created by liuwanwei on 2021/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Schedule : NSObject

/**
 * 从哪天开始训练
 */
@property (nonatomic, strong) NSDate * startDate;

/**
 * 一共训练几天
 */
@property (nonatomic) NSInteger maxDays;

/**
 * 训练记录，包含该日是否完成训练，以及当日完成训练的时间
 */
@property (nonatomic, strong) NSArray * records;

+ (instancetype)defaultInstance;

/**
 * 某日训练完成后，记录完成时间，第一天从 0 开始
 */
- (void)setFinish:(NSInteger)index;

/**
 * 判断某天是否完成了训练，第一天从 0 开始
 */
- (BOOL)isFinished:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
