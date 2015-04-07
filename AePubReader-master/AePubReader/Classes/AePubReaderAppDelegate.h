//
//  AePubReaderAppDelegate.h
//  AePubReader
//
//  Created by Federico Frappi on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"


@class EPubViewController;


@interface AePubReaderAppDelegate : NSObject <UIApplicationDelegate,UINavigationControllerDelegate> {
    
    UIWindow *window;
        
    EPubViewController *detailViewController;
    ListViewController *listStory;
     UINavigationController *navigation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet EPubViewController *detailViewController;
@property (nonatomic, retain) IBOutlet  ListViewController *listStory;
@property (nonatomic, retain) UINavigationController *navigation;



@end
