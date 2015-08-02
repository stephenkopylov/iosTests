#import "ViewController.h"

@implementation ViewController {
    UIView *v;
    dispatch_queue_t backgroundRenderQueue;
    CFTimeInterval beginTime;
    NSTimer *timer;
    NSInteger timerCallCount;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setup];
}
-(void)setup {
    //create a view to hold a bunch of CALayers
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    v.center = CGPointMake(0,0);
    
    //create a buch of CALayers and add them to a view
    for(int i = 0; i < 10000; i++) {
        CALayer *l = [[CALayer alloc] init];
        l.frame = CGRectMake([self random:390],[self random:390],10,10);
        l.backgroundColor = [UIColor blueColor].CGColor;
        l.borderColor = [UIColor orangeColor].CGColor;
        l.borderWidth = 2.0f;
        [v.layer addSublayer:l];
    }
    //add the view to the application's main view
    [self.view addSubview:v];
}

-(NSInteger)random:(NSInteger)value {
    srandomdev();
    return ((NSInteger)random())%value;
}

-(void)touchesBegan {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(printTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [self render];
}

-(void)printTime {
    NSLog(@"%ld (main thread running)",(long)++timerCallCount);
}

-(void)render {
    NSLog(@"render was called");
    //create the queue
    backgroundRenderQueue = dispatch_queue_create("backgroundRenderQueue",DISPATCH_QUEUE_CONCURRENT);
    //create a async call on the background queue
    dispatch_async(backgroundRenderQueue, ^{
        //create a cgcontext
        NSUInteger width = (NSUInteger)v.frame.size.width;
        NSUInteger height = (NSUInteger)v.frame.size.height;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * width;
        unsigned char *rawData = malloc(height * bytesPerRow);
        NSUInteger bitsPerComponent = 8;
        CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        
        //render the layer and its subviews
        //NOTE: if your layers aren't all in the same sublayer
        //you can easily call a for(..;..;..) that translates the context to and from the origin of each CALayer
        //and draw each layer individually into the context itself
        [v.layer renderInContext:context];
        
        //create a callback async on the main queue when rendering is complete
        dispatch_async(dispatch_get_main_queue(), ^{
            //create an image from the context
            UIImage *m = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
            UIImageView *uiiv = [[UIImageView alloc] initWithImage:m];
            //add the image view to the main view
            [self.view addSubview:uiiv];
            CGColorSpaceRelease(colorSpace);
            CGContextRelease(context);
            NSLog(@"rendering complete");
            [timer invalidate];
        });
    });
}
@end