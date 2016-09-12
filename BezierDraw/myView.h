//
//  myView.h
//  BezierDraw
//
//  Created by andrew hazlett on 8/10/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "myPoint.h"
#import "drawLine.h"

@interface myView : NSView

@property (retain) NSMutableArray  * myMutaryOfPoints;
@property (retain) NSMutableArray  * myBoxes;

//@property (nonatomic) int mouseCount;

@end
