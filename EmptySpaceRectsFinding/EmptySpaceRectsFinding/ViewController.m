//
//  ViewController.m
//  EmptySpaceRectsFinding
//
//  Created by Stephen Kopylov - Home on 19/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSArray <NSValue *> *rects;

@end

@implementation ViewController {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.rects = @[
                   [NSValue valueWithCGRect:CGRectMake(10.0f, 400.0f, 100.0f, 200.0f)],
                   [NSValue valueWithCGRect:CGRectMake(200.0f, 300.0f, 100.0f, 50.0f)],
                   [NSValue valueWithCGRect:CGRectMake(200.0f, 500.0f, 100.0f, 50.0f)]
                   ];
    [self drawHoles];
    NSLog(@"123");
    test(self, @(self.view.frame.size.width).intValue, @(self.view.frame.size.height).intValue);
    NSLog(@"123");
}


- (void)drawHoles
{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.rects enumerateObjectsUsingBlock:^(NSValue *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGRect rect = [obj CGRectValue];
        
        UIView *view = [UIView new];
        view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        view.frame = rect;
        
        [self.view addSubview:view];
    }];
}


- (BOOL)pointInRects:(CGPoint)point
{
    __block BOOL pointInPath = NO;
    
    [self.rects enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL *_Nonnull stop) {
        CGRect rect = [value CGRectValue];
        
        if ( CGPathContainsPoint([UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5].CGPath, nil, point, YES) ) {
            pointInPath = YES;
            *stop = YES;
        }
    }];
    
    return pointInPath;
}


- (void)drawFrame:(CGRect)rect
{
    UIView *testView = [UIView new];
    
    testView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    testView.frame = rect;
    
    [self.view addSubview:testView];
}


typedef struct {
    int one;
    int two;
} Pair;

Pair best_ll = { 0, 0 };
Pair best_ur = { -1, -1 };
int best_area = 0;

int *c;
Pair *s;
int top = 0;

void push(int a, int b)
{
    s[top].one = a;
    s[top].two = b;
    ++top;
}


void pop(int *a, int *b)
{
    --top;
    *a = s[top].one;
    *b = s[top].two;
}


int M, N;

void update_cache(id cSelf, int height)
{
    int m;
    //    char b;
    bool empty = false;
    
    for ( m = 0; m != M; ++m ) {
        CGPoint point = CGPointMake(m, height);
        
        empty = ![cSelf pointInRects:point];
        
        if ( !empty ) {
            c[m] = 0;
        }
        else {
            ++c[m];
        }
    }
}


int test(id cSelf, int width, int height)
{
    int m, n;
    
    M = width;
    N = height;
    
    c = (int *)malloc((M + 1) * sizeof(int));
    s = (Pair *)malloc((M + 1) * sizeof(Pair));
    
    for ( m = 0; m != M + 1; ++m ) {
        c[m] = s[m].one = s[m].two = 0;
    }
    
    /* Main algorithm: */
    for ( n = 0; n != N; ++n ) {
        int open_width = 0;
        update_cache(cSelf, n);
        
        for ( m = 0; m != M + 1; ++m ) {
            if ( c[m] > open_width ) {
                push(m, open_width);
                open_width = c[m];
            }
            else
                if ( c[m] < open_width ) {
                    int m0, w0, area;
                    do {
                        pop(&m0, &w0);
                        area = open_width * (m - m0);
                        
                        if ( area > best_area ) {
                            best_area = area;
                            best_ll.one = m0; best_ll.two = n;
                            best_ur.one = m - 1; best_ur.two = n - open_width + 1;
                        }
                        
                        open_width = w0;
                    } while ( c[m] < open_width );
                    open_width = c[m];
                    
                    if ( open_width != 0 ) {
                        push(m0, w0);
                    }
                }
        }
    }
    
    //    fprintf(stderr, "The maximal rectangle has area %d.\n", best_area);
    //    fprintf(stderr, "Location: [col=%d, row=%d] to [col=%d, row=%d]\n",
    //            best_ll.one + 1, best_ll.two + 1, best_ur.one + 1, best_ur.two + 1);
    [cSelf drawFrame:CGRectMake(best_ll.one, best_ur.two, best_ur.one - best_ll.one, best_ll.two - best_ur.two)];
    
    return 0;
}


@end
