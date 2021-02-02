//
//  ViewController.h
//  pushups-14
//
//  Created by liuwanwei on 2021/1/26.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView * tableView;

@end

