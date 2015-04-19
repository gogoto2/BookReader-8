
#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ReaderDemoController : UIViewController <ADBannerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    ADBannerView *_adBanner;
    BOOL _bannerIsVisible;
    NSMutableArray *lisdata;
    UITableView *tblTable;
    
}
@end
