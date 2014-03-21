//
//  ViewController.m
//  SwipeEdgeGesture
//
//  Created by Paul Solt on 3/21/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *leftDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDistanceLabel;
@property (weak, nonatomic) IBOutlet UIView *panView;
@property (weak, nonatomic) IBOutlet UILabel *panGestureLabel;
@property (weak, nonatomic) IBOutlet UISwitch *multipleGesturesSwitch;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;
    leftEdgeGesture.delegate = self;
    [self.view addGestureRecognizer:leftEdgeGesture];
    
    UIScreenEdgePanGestureRecognizer *rightEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightEdgeGesture:)];
    rightEdgeGesture.edges = UIRectEdgeRight;
    rightEdgeGesture.delegate = self;
    [self.view addGestureRecognizer:rightEdgeGesture];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.panView addGestureRecognizer:panGesture];
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    
    CGPoint translation = [gesture translationInView:gesture.view];
    self.panGestureLabel.text = [NSString stringWithFormat:@"(%0.0f, %0.0f)", translation.x, translation.y];

    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    // You can customize the way in which gestures can work
    
    // Enabling multiple gestures will allow all of them to work together, otherwise only the topmost view's gestures will work (i.e. PanGesture view on bottom)
    
    return self.multipleGesturesSwitch.on;
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        CGPoint translation = [gesture translationInView:gesture.view];
        self.leftDistanceLabel.text = [NSString stringWithFormat:@"%0.1f", translation.x];
    } else {  // cancel, fail, or ended
        // reset
        self.leftDistanceLabel.text = @"0.0";
    }
    
}

- (void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        CGPoint translation = [gesture translationInView:gesture.view];
        self.rightDistanceLabel.text = [NSString stringWithFormat:@"%0.1f", translation.x];
    } else {  // cancel, fail, or ended
        // reset
        self.rightDistanceLabel.text = @"0.0";
    }
    
}

@end
