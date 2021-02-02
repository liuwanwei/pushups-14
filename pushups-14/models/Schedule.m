//
//  Schedule.m
//  pushups-14
//
//  Created by liuwanwei on 2021/1/26.
//

#import "Schedule.h"

#define kStartDate      @"schedule_start_date"
#define kRecords        @"pushup_records"

@implementation Schedule

+ (instancetype)defaultInstance{
    static Schedule * sInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sInstance == nil) {
            sInstance = [[Schedule alloc] init];
        }
    });
    
    return sInstance;
}

- (id)init{
    if (self = [super init]) {
        [self _loadSetting];
    }
    
    return self;
}

- (void)_loadSetting{
    self.maxDays = 14;
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSDate * date = [ud objectForKey:kStartDate];
    if (date == nil) {
        // 初始化为软件第一次运行的日期
        date = [NSDate date];
        [ud setObject:date forKey:kStartDate];
    }
    self.startDate = date;
    
    NSArray * records = [ud objectForKey:kRecords];
    if (records == nil) {
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:self.maxDays];
        for (int i = 0; i < self.maxDays; i ++) {
            array[i] = @(NO);
        }
        
        records = array;
    }
    self.records =  records;
}


- (void)setFinish:(NSInteger)index{
    NSMutableArray * mutable = [self.records mutableCopy];
    mutable[index] = [NSDate date];
    self.records = mutable;
    [[NSUserDefaults standardUserDefaults] setObject:mutable forKey:kRecords];
}

- (BOOL)isFinished:(NSInteger)index{
    id obj = self.records[index];
    return [obj isKindOfClass:[NSDate class]];
}

@end
