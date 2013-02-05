/*
 * Copyright (c) 05/02/2013 Mario Negro (@emenegro)
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "MNMRemoteImageView.h"

@interface MNMRemoteImageView()

/*
 * The URL of the image.
 */
@property (nonatomic, readwrite, copy) NSString *url;

/*
 * Activity indicator to be shown while image is downloaded
 */
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *activityIndicator;

/*
 * Initialize control
 */
- (void)initializeControl;

@end

@implementation MNMRemoteImageView

@synthesize url = url_;
@synthesize activityIndicator = activityIndicator_;

#pragma mark - Instance initialization

/*
 * Initialize control
 */
- (void)initializeControl {

    if (self) {
        
        activityIndicator_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator_ setHidesWhenStopped:YES];
        [activityIndicator_ setCenter:CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]))];
        [activityIndicator_ setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
        [self addSubview:activityIndicator_];
    }
}

/*
 * Designated initalizer
 */
- (id)init {
    
    if (self = [super init]) {
        
        [self initializeControl];
    }
    
    return self;
}

/*
 * Returns an object initialized from data in a given unarchiver. (required)
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initializeControl];        
    }
    
    return self;
}

/*
 * Initializes and returns a newly allocated view object with the specified frame rectangle.
 */
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initializeControl];        
    }
    
    return self;
}

/*
 * Returns an image view initialized with the specified image.
 */
- (id)initWithImage:(UIImage *)image {
    
    if (self = [super initWithImage:image]) {
        
        [self initializeControl];
    }
    
    return self;
}

/*
 * Returns an image view initialized with the specified regular and highlighted images.
 */
- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        
        [self initializeControl];
    }
    
    return self;
}

#pragma mark - Visuals

/*
 * Downloads and displays the image from the given URL.
 */
- (void)displayImageFromURL:(NSString *)url
          completionHandler:(void(^)(NSError *error))completionBlock {
    
    if ([url length] > 0 && ![url_ isEqualToString:url]) {
        
        [self setImage:nil];
        url_ = [url copy];
        [activityIndicator_ startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSError *error = nil;
                [activityIndicator_ stopAnimating];
                
                if (image != nil) {
                    
                    [self setImage:image];
                    
                } else {
                    
                    error = [NSError errorWithDomain:@"com.marionegro.remoteimageview"
                                                code:-1
                                            userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Cannot download image from '%@'", url_] }];
                }
                
                completionBlock(error);
            });
        });
    }
}

@end
