//
//  ViewController.m
//  pushups-14
//
//  Created by liuwanwei on 2021/1/26.
//

#import "ViewController.h"
#import "Schedule.h"

@interface ViewController (){
    Schedule * _model;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"坚持十四天";
    _model = [Schedule defaultInstance];
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    NSDate * now = [NSDate date];
    NSDate * cellDate = [_model.startDate dateByAddingTimeInterval:index * 3600 * 24];
    NSInteger dayChange = [self getDaysFrom:cellDate to:now];
    if (dayChange > 0) {
        NSLog(@"已经过期，不能点");
    }else if (dayChange < 0){
        NSLog(@"还没到时候，不能点");
    }else{
        NSLog(@"可以点，我点了");
        UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"确定完成训练吗？" message:@"此行为无法撤销。" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (! [self->_model isFinished:index]) {
                [self->_model setFinish:index];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }]];
        [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:ac animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    NSDate * now = [NSDate date];
    NSDate * cellDate = [_model.startDate dateByAddingTimeInterval:index * 3600 * 24];
    NSString * text = [self _formatDate:cellDate];
    NSInteger dayChange = [self getDaysFrom:cellDate to:now];
    if (dayChange > 0) {
        if (! [_model isFinished:index]) {
            text = [text stringByAppendingString:@" - 已过期"];
        }
    }
    cell.textLabel.text = text;
    
    if ([_model isFinished:index]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 个", @(index + 14)];
}

- (NSInteger)getDaysFrom:(NSDate *)from to:(NSDate *)to{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDate * fromZero = [calendar startOfDayForDate:from];
    NSDate * toZero = [calendar startOfDayForDate:to];
        
    NSUInteger flags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    //|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents * cps = [calendar components:flags fromDate:fromZero toDate:toZero options:0];
    return [cps day];
}

- (NSString *)_formatDate:(NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.maxDays;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * sId = @"day_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sId];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

@end
