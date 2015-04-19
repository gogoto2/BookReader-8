

#import "ReaderAppDelegate.h"
#import "ReaderDemoController.h"

@implementation ReaderAppDelegate
{
	UIWindow *mainWindow; // Main App Window

	UINavigationController *navigationController;

	ReaderDemoController *readerDemoController;
}

#pragma mark - UIApplicationDelegate methods

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	mainWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]; // Main application window

	readerDemoController = [[ReaderDemoController alloc] initWithNibName:nil bundle:nil]; // Demo controller

	navigationController = [[UINavigationController alloc] initWithRootViewController:readerDemoController];

	mainWindow.backgroundColor = [UIColor grayColor]; // Neutral gray window background color

	navigationController.navigationBar.barStyle = UIBarStyleBlack; navigationController.navigationBar.translucent = YES;

	mainWindow.rootViewController = navigationController; // Set the root view controller

	[mainWindow makeKeyAndVisible];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of
	// temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application
	// and it begins the transition to the background state. Use this method to pause ongoing tasks, disable timers,
	// and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough
	// application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of transition from the background to the inactive state: here you can undo many
	// of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive.
	// If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate.
	// See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	// Free up as much memory as possible by purging cached data objects that can be recreated
	// (or reloaded from disk) later.
}

@end
