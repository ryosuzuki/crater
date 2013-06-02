//
//  nasaFirstViewController.m
//  crater
//
//  Created by Ryo Suzuki on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "nasaThirdViewController.h"


@implementation nasaThirdViewController

@synthesize sphere_id;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Third", @"Third");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    } 
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    sphere_id = [[NSNumber alloc] initWithInteger: 3];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    //    scrollView.backgroundColor = [UIColor lightGrayColor];
    
    
    
    [self.view addSubview:scrollView];
    
    connection = [[NSURLConnection alloc] init];
    
    IDs = [[NSMutableArray alloc] init];
    imageURL = [[NSMutableArray alloc] init];
    
    
    [self getCraters:0 :50];
    NSLog(@"%@", imageURL);
    NSLog(@"%@", IDs.lastObject);
    
    float width = 320;
    float height = 80 * (imageURL.count / 4) + 80;
    scrollView.contentSize = CGSizeMake(width,height);
    
    
    [self thumbnailView:imageURL];
    
    
    
    
    
}

- (void)thumbnailView:(NSMutableArray *)array
{
    NSInteger i;
    imageList = [[NSMutableArray alloc] init];
    
    for (i = 0; i < array.count; i++) {
        NSLog(@"%d", i);
        NSURL* url = [NSURL URLWithString:[array objectAtIndex:i]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        UIImage* image = [UIImage imageWithData:response];
        [imageList addObject:image];
    }
    
    imageViewList = [[NSMutableArray alloc] init];
    
    NSInteger index = 0;
    NSInteger index_x;
    NSInteger index_y;
    for (UIImage *image in imageList) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        index_x = index % 4;
        index_y = index / 4; 
        NSLog(@"%d", index_y * 80);
        
        imageView.frame = CGRectMake(80 * index_x, 80 * index_y, 80, 80);
        [scrollView addSubview:imageView];
        
        [imageViewList addObject:imageView];
        index ++;        
    }
    UIView *loadMore = [[UIView alloc] init];
    if (index % 4 != 0) {
        loadMore.frame = CGRectMake(80 * (index_x + 1), 80 *index_y, 80, 80);
    } else {
        loadMore.frame = CGRectMake(0, 80 * (index_y + 1), 80, 80);
    }
    loadMore.backgroundColor = [UIColor lightGrayColor];
    UILabel *loadText = [[UILabel alloc] init];
    loadText.text = @"load more";
    loadText.font = [UIFont fontWithName:@"GillSans-Bold" size:18];
    loadText.numberOfLines = 2;
    loadText.textAlignment = UITextAlignmentCenter;
    loadText.textColor = [UIColor whiteColor];
    loadText.backgroundColor = [UIColor clearColor];
    loadText.frame = CGRectMake(0, 0, 80, 80);
    [loadMore addSubview:loadText];

    [scrollView addSubview:loadMore];
    
    
    
    
    for (UIImageView *imageView in imageViewList) {
        UITapGestureRecognizer *tapped 
        = [[UITapGestureRecognizer alloc] 
           initWithTarget:self action:@selector(myFunction:)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = [imageViewList indexOfObject:imageView];
        [imageView addGestureRecognizer:tapped];
        
        
        layer = [imageView layer];
        
        [layer setBorderWidth:1.5f];
        [layer setBorderColor:[[UIColor whiteColor] CGColor]];
        
    }
    
    UITapGestureRecognizer *loadtap
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadMore)];
    [loadMore addGestureRecognizer:loadtap];
    
    layer = [loadMore layer];
    [layer setBorderWidth:3.0f];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
}

- (void)loadMore
{
    [self getCraters:IDs.count :10];
    NSLog(@"%@", imageURL);
    NSLog(@"%@", IDs.lastObject);
    
    float width = 320;
    float height = 80 * (imageURL.count / 4) + 80;
    scrollView.contentSize = CGSizeMake(width,height);
    
    
    [self thumbnailView:imageURL];
    
}

- (void)myFunction:(UITapGestureRecognizer *)sender
{
    gesture = (UITapGestureRecognizer *) sender;
    
    imageFrame = CGRectMake(0, -40, 200, 200);
    
    [scrollView addSubview:gesture.view];
    currentFrame = gesture.view.frame;
    [self.view addSubview:gesture.view];
    
    [UIView transitionWithView:gesture.view 
                      duration:1.5 
                       options:UIViewAnimationOptionTransitionFlipFromRight
     
                    animations:^{
                        gesture.view.center = self.view.center;    
                        gesture.view.transform =CGAffineTransformMakeScale(1, 1);
                        gesture.view.bounds = imageFrame;
                        
                    }
                    completion:^(BOOL finished){
                        
                        [self endAnimation];
                    }
     ];
    
}


- (void)endAnimation
{
    modalView = [[UIView alloc] init];
    modalView.frame = self.view.frame;
    modalView.center = self.view.center;
    modalView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    modalView.alpha = 0;
    
    [UIView transitionWithView:modalView 
                      duration:1 
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        modalView.alpha = 1;
                        
                    }
                    completion:nil
     ];    
    
    UIImageView *inner = [[UIImageView alloc] init];
    inner.center = modalView.center;
    inner.bounds = imageFrame;
    inner.image = [imageList objectAtIndex:gesture.view.tag];
    
    layer = [inner layer];
    [layer setBorderWidth:3.0f];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    NSInteger getCraterID = [[IDs objectAtIndex:gesture.view.tag] intValue];
    NSDictionary *detailDict = [self getDetail:getCraterID];
    
    NSString *crater_id = [detailDict valueForKey:@"id"];
    NSString *sphere = [detailDict valueForKey:@"sphere_id"];
    NSString *name = [detailDict valueForKey:@"name"];
    NSString *image_url = [detailDict valueForKey:@"image_url"];
    NSString *latitude = [detailDict valueForKey:@"latitude"];
    NSString *longitude = [detailDict valueForKey:@"longitude"];
    
    NSLog(@"%@ %@ %@ %@ %@ %@", crater_id, sphere, name, image_url, latitude, longitude);
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    UILabel *detailLabel = [[UILabel alloc] init];
    
    nameLabel.frame = CGRectMake(0, 50, 320, 50);
    detailLabel.frame = CGRectMake(0, 310, 320, 50);
    
    nameLabel.backgroundColor = [UIColor clearColor];
    detailLabel.backgroundColor = [UIColor clearColor];
    
    
    nameLabel.text = name;
    NSString *detail = [NSString stringWithFormat:@"Latitude : %@   Longitude : %@", latitude, longitude];
    nameLabel.text = name;
    detailLabel.text = detail;
    
    nameLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:28];
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    detailLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:17];
    detailLabel.textAlignment = UITextAlignmentCenter;
    detailLabel.textColor = [UIColor whiteColor];
    
    
    nameLabel.alpha = 0;
    detailLabel.alpha = 0;
    [modalView addSubview:nameLabel];
    [modalView addSubview:detailLabel];
    
    
    
    [UIView transitionWithView:nameLabel 
                      duration:1
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        nameLabel.alpha = 1;
                        detailLabel.alpha = 1;
                    }
                    completion:nil
     ];
    
    
    
    
    modalView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [modalView addSubview:inner];
    
    [self.view addSubview:modalView];
    
    UIPinchGestureRecognizer *pinch 
    = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [modalView addGestureRecognizer:pinch];
}

- (void)pinchAction:(UIPinchGestureRecognizer *)sender
{
    CGFloat scale = [sender scale];
    modalView.transform = CGAffineTransformMakeScale(scale, scale);
    
    modalView.alpha = scale * scale;
    gesture.view.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (scale < 0.7) {
        [modalView removeFromSuperview];
        [self myFunctionEnd];
    }
}

- (void)myFunctionEnd
{
    
    gesture.view.transform =CGAffineTransformMakeScale(0.7, 0.7);
    
    [UIView transitionWithView:gesture.view 
                      duration:1.5 
                       options:UIViewAnimationOptionTransitionFlipFromLeft
     
                    animations:^{
                        [scrollView addSubview:gesture.view];
                        gesture.view.frame = currentFrame;
                        self.view.alpha = 1;
                        
                    }
                    completion:^(BOOL finished){
                    }
     ];
    
    
}



- (void)getCraters:(NSInteger)offset :(NSInteger)count
{
    NSString *apiURL = [NSString stringWithFormat:@"http://craters.heroku.com/api/crater_list?sphere_id=%@&offset=%d&count=%d", sphere_id, offset, count];
    
    NSURL* url = [NSURL URLWithString:apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSJapaneseEUCStringEncoding];
    
    cratersArray = [[NSMutableArray alloc] initWithArray:[jsonString JSONValue]];
    
    for (NSInteger i = 0; i < cratersArray.count ; i++) {
        cratersDict = [[NSMutableDictionary alloc] initWithDictionary:[cratersArray objectAtIndex:i]];
        
        if ([[cratersDict valueForKey:@"image_url"] isEqual:[NSNull null]] == FALSE)
        {
            [IDs addObject:[cratersDict valueForKey:@"id"]];
            [imageURL addObject:[cratersDict valueForKey:@"image_url"]];            
        }
        
    }    
    
}


- (NSDictionary *)getDetail:(NSInteger)crater_id
{
    NSString *apiURL = [NSString stringWithFormat:@"http://craters.heroku.com/api/crater?crater_id=%d", crater_id];
    NSURL* url = [NSURL URLWithString:apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSJapaneseEUCStringEncoding];
    
    NSDictionary *detailDict = [[NSDictionary alloc] initWithDictionary:[jsonString JSONValue]];
    
    return detailDict;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
