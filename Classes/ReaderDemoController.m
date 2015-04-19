
#import "ReaderDemoController.h"
#import "ReaderViewController.h"

@interface ReaderDemoController () <ReaderViewControllerDelegate>

@end

@implementation ReaderDemoController

#pragma mark - Constants

#define DEMO_VIEW_CONTROLLER_PUSH FALSE
#define DF_Color_RGB(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.backgroundColor = DF_Color_RGB(75, 131, 217); // Transparent

	self.title = [[NSString alloc] initWithFormat:@"Book Reader"];

    
    if ( !lisdata ) {
        lisdata = [[NSMutableArray alloc] init];
    }
    lisdata = [self loadData];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat width = CGRectGetWidth(screen);
    //Bonus height.
    CGFloat height = CGRectGetHeight(screen);
    tblTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    tblTable.delegate = self;
    tblTable.dataSource = self;
    [self.view addSubview:tblTable];
//    for (int i = 0; i < [lisdata count]; i++) {
//
//        UIButton *tapLabel = [[UIButton alloc] initWithFrame:CGRectMake(20, 80 + 35*i, 300, 35)];
//        tapLabel.backgroundColor = [UIColor clearColor];
//        [tapLabel setTitle:[lisdata objectAtIndex:i] forState:UIControlStateNormal];
//        [tapLabel addTarget:self action:@selector(didselect:) forControlEvents:UIControlEventTouchUpInside];
//        tapLabel.tag = i;
//        [self.view addSubview:tapLabel];
//    }
    float padding = 0;
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 ) {
        padding = 40;
    }
    _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - padding, self.view.frame.size.width, 70)];
    _adBanner.delegate = self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lisdata count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        NSString *indexNumber = [lisdata objectAtIndex:indexPath.row];
        NSString *identifier = [NSString stringWithFormat:@"Cell %@", indexNumber];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [lisdata objectAtIndex:indexPath.row];
        }
        return cell;
    }
    @catch (NSException *exception) {
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        
        NSString *nameSong = [lisdata objectAtIndex:indexPath.row];
        nameSong = [nameSong stringByAppendingString:@".pdf"];
        NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
        
        NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
        NSString *filePath = [pdfs firstObject]; assert(filePath != nil); // Path to first PDF file
        
        for (int i = 0 ; i< [pdfs count]; i++) {
            NSArray *totalName = [[pdfs objectAtIndex:i] componentsSeparatedByString:@"/"];
            NSString *valuesName = [totalName objectAtIndex:[totalName count]-1];
            if ([valuesName isEqualToString:nameSong]) {
                filePath = [pdfs objectAtIndex:i];
                break;
            }
        }
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
        
        if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            
            readerViewController.delegate = self; // Set the ReaderViewController delegate to self
            
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
            
            [self.navigationController pushViewController:readerViewController animated:YES];
            
#else // present in a modal view controller
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:readerViewController animated:YES completion:NULL];
            
#endif // DEMO_VIEW_CONTROLLER_PUSH
        }
        else // Log an error so that we know that something went wrong
        {
            NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
        }
        
    }
    @catch (NSException *exception) {
        
    }
}
-(void)didselect:(id)sender
{


    
}
-(NSMutableArray*)loadData
{
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *direnum = [manager enumeratorAtPath:bundleRoot];
    NSString *filename;
    
    while ((filename = [direnum nextObject] )) {
        
        //change the suffix to what you are looking for
        if ([filename hasSuffix:@".pdf"]) {
            NSArray *array = [filename componentsSeparatedByString:@"."];
            if ([array count] > 0) {
                NSString *nameFile = [array objectAtIndex:0];
                [lisdata addObject:nameFile];
            }
        }
    }
    return lisdata;
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:NO animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:YES animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
#ifdef DEBUG
	NSLog(@"%s", __FUNCTION__);
#endif

	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) // See README
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return YES;
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}

- (void)didReceiveMemoryWarning
{
#ifdef DEBUG
	NSLog(@"%s", __FUNCTION__);
#endif

	[super didReceiveMemoryWarning];
}

#pragma mark - UIGestureRecognizer methods

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
	NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)

	NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];

	NSString *filePath = [pdfs firstObject]; assert(filePath != nil); // Path to first PDF file

	ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];

	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];

		readerViewController.delegate = self; // Set the ReaderViewController delegate to self

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

		[self.navigationController pushViewController:readerViewController animated:YES];

#else // present in a modal view controller

		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;

		[self presentViewController:readerViewController animated:YES completion:NULL];

#endif // DEMO_VIEW_CONTROLLER_PUSH
	}
	else // Log an error so that we know that something went wrong
	{
		NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
	}
}

#pragma mark - ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController popViewControllerAnimated:YES];

#else // dismiss the modal view controller

	[self dismissViewControllerAnimated:YES completion:NULL];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

@end
