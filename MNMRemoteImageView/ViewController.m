//
//  ViewController.m
//  MNMRemoteImageView
//
//  Created by Mario Negro on 05/02/13.
//  Copyright (c) 2013 Mario Negro. All rights reserved.
//

#import "ViewController.h"
#import "MNMRemoteImageView.h"

@interface ViewController ()

@property (nonatomic, readwrite, weak) IBOutlet MNMRemoteImageView *remoteImageView;
@property (nonatomic, readwrite, weak) IBOutlet UIButton *loadRemoteButton;
- (IBAction)loadRemoteTouchedUpInside;

@end

@implementation ViewController

@synthesize remoteImageView = remoteImageView_;
@synthesize loadRemoteButton = loadRemoteButton_;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [remoteImageView_ setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadRemoteTouchedUpInside {
    
    [loadRemoteButton_ setEnabled:NO];
    static NSInteger count = 0;
    count = (count + 1 > 3 ? 1 : count + 1);
    NSString *url = nil;

    if (count == 1) {
        url = @"http://pmunnie.files.wordpress.com/2010/10/rind.jpg";
    } else if (count == 2) {
        url = @"http://4.bp.blogspot.com/-RkBxVsz2CE8/TvOUhXhczMI/AAAAAAAAGVA/lV4SPLgLS2k/s1600/Hand_with_reflecting_globe.jpg";
    } else if (count == 3) {
        url = @"http://upload.wikimedia.org/wikipedia/en/thumb/a/a3/Escher's_Relativity.jpg/250px-Escher's_Relativity.jpg";
    }
    
    [remoteImageView_ displayImageFromURL:url
                        completionHandler:^(NSError *error) {
                            
                            if (error) {
                                
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                message:[error localizedDescription]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil];
                                [alert show];
                            }
                            
                            [loadRemoteButton_ setEnabled:YES];
                        }];
}

@end
