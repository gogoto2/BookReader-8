//
//  ListViewController.h
//  AePubReader
//
//  Created by Nguyen Huu Hoang on 4/7/15.
//
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@class EPubViewController;

@interface ListViewController  : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tblDataList;
    IBOutlet UITableView *tblView;
//     DetailViewController *detailViewController;
       EPubViewController *detailViewController;
    
}
@property (nonatomic,assign)  NSMutableArray *tblDataList;
@property (nonatomic,retain)EPubViewController *detailViewController;
@end

