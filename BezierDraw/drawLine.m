//
//  drawLine.m
//  BezierDraw
//
//  Created by andrew hazlett on 9/12/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "drawLine.h"

@implementation drawLine

-(void)myLine{
    int locX1 = 10;
    int locY1 = 10;
    
    int locX2 = 10;
    int locY2 = 200;
    
    NSBezierPath *Path = [NSBezierPath bezierPath];
    [Path moveToPoint:NSMakePoint(locX1, locY1)];
    [Path lineToPoint:NSMakePoint(locX2, locY2)];
    [Path setLineWidth:5.0];
    [[NSColor blueColor] set];
    [Path stroke];
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

@end
