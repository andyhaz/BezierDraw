//
//  myView.m
//  BezierDraw
//
//  Created by andrew hazlett on 8/10/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "myView.h"

@interface myView (){
  //  int mouseLocX;
  //  int mouseLocY;
  //  NSMutableArray *mouseStoreX,*mouseStoreY;
//    int locX,locY;
    short mouseClick,pointSelect;
    NSBezierPath *Box;
}
@end

@implementation myView

@synthesize myMutaryOfPoints,myBoxes;

-(void)mouseDown:(NSEvent *)theEvent{
    if (!myMutaryOfPoints) myMutaryOfPoints = [[NSMutableArray alloc] init];
    if (!myBoxes) myBoxes = [[NSMutableArray alloc] init];
    if (!mouseClick) mouseClick = 1;
    if (pointSelect) pointSelect = 0;
    NSPoint tvarMousePointInWindow = [theEvent locationInWindow];
    NSPoint tvarMousePointInView   = [self convertPoint:tvarMousePointInWindow fromView:nil];
    myPoint *tvarMyPointObj       = [[myPoint alloc]initWithNSPoint:tvarMousePointInView];
    
    //locX = [tvarMyPointObj x];
    //locY = [tvarMyPointObj y];
    
    switch (mouseClick) {
        case 1:
          //  NSLog(@"first point");
            [myMutaryOfPoints addObject:tvarMyPointObj];
            mouseClick ++;
            break;
        case 2:
         //   NSLog(@"add lines ");
            [myMutaryOfPoints addObject:tvarMyPointObj];
            [myMutaryOfPoints addObject:tvarMyPointObj];
            
            //update with new middle
            myMutaryOfPoints = [self middleLocation:myMutaryOfPoints];
            mouseClick = 2;
            break;
        case 3:
            NSLog(@"click:%hhd",[Box containsPoint:tvarMousePointInView]);
         /*if ([PathA containsPoint:tvarMousePointInView] == true) {
                NSLog(@"hit test A");
                pointSelect = 0;
            }
          */
            break;
        default:
            break;
    }
}

-(void)mouseUp:(NSEvent *)theEvent{
//set array cauculation
    [self setNeedsDisplay:YES];
}//end

- (void)drawRect:(NSRect)dirtyRect {
   //Drawing code here.
    [super drawRect:dirtyRect];
    [[NSColor blackColor] setFill];
    NSRectFill( dirtyRect);
    
    if (myMutaryOfPoints) [self WileECoyote];
   // drawLine *dl = [[drawLine alloc]init];
   // [dl myLine];
}

-(void)WileECoyote {
    //set up drawing objects
    Box = [NSBezierPath bezierPath];
    int locX1 = 0,locY1 = 0;
    int locX2 = 0,locY2 = 0;

    short pountCount = [myMutaryOfPoints count];
    //NSLog(@"array count:%d",pountCount);

    NSBezierPath *line = [NSBezierPath bezierPath];

    for (int i = 0; i < pountCount; i++) {
        //draw box location
        Box = [NSBezierPath bezierPathWithRect:NSMakeRect((int)[myMutaryOfPoints[i] x],(int)[myMutaryOfPoints[i] y], 10, 10)];
        // [[NSColor whiteColor] set];
        // [Path fill];
        [[NSColor whiteColor] set];
        [Box setLineWidth:2.0];
        [Box stroke];
//draw line
        if (i == 0) {
        //   NSLog(@"move to:%d",i);
           locX1  = (int)[myMutaryOfPoints[i] x];
           locY1  = (int)[myMutaryOfPoints[i] y];
           [line moveToPoint:NSMakePoint(locX1, locY1)];
        }

        if (i >= 1) {
         //   NSLog(@"draw to:%d",i);
            locX2 = (int)[myMutaryOfPoints[i] x];
            locY2 = (int)[myMutaryOfPoints[i] y];
            [line lineToPoint:NSMakePoint(locX2, locY2)];
        }
        
        [line setLineWidth:2.0];
        [[NSColor blueColor] set];
        [line stroke];
    }//end loop
    
    //creat curve
    if (pountCount >= 2) {
      //  NSLog(@"creat curve");
        NSBezierPath *curve = [NSBezierPath bezierPath];
        int index1 = 0;
        int index2 = 1;
        int index3 = 2;
        
        [curve moveToPoint:NSMakePoint((int)[myMutaryOfPoints [index1] x],(int)[myMutaryOfPoints [index1] y])];
      //NSLog(@"index vaule1:%d",index1);
        for (int i = 0; i < pountCount/2; i++) {
          //  NSLog(@"index vaule2:%d vaule3:%d",index2,index3);
     
            [curve curveToPoint:NSMakePoint((int)[myMutaryOfPoints [index3] x],(int)[myMutaryOfPoints [index3] y])
                  controlPoint1:NSMakePoint((int)[myMutaryOfPoints [index2] x],(int)[myMutaryOfPoints [index2] y])
                  controlPoint2:NSMakePoint((int)[myMutaryOfPoints [index2] x],(int)[myMutaryOfPoints [index2] y])];
            index2 += 2;
            index3 += 2;
            
            [curve setLineWidth:2.0];
            [[NSColor redColor] set];
            [curve stroke];
        }//end loop
 
        // [[NSColor whiteColor] set];
        // [curve fill];
    }//creat curve
}

/*-(void)drawSquareBackgroundSolidColor {
   // NSLog(@"myMutaryOfPoints:%@",myMutaryOfPoints);
    for (int i = 0; i < myMutaryOfPoints.count; i++) {
        locX = (int)[myMutaryOfPoints[i] x];
        locY = (int)[myMutaryOfPoints[i] y];
   //     NSLog(@"myMutaryOfPoints X:%d y:%d",locX,locY);
        Path = [NSBezierPath bezierPathWithRect:NSMakeRect(locX,locY, 10, 10)];
   // [[NSColor whiteColor] set];
   // [Path fill];
        [[NSColor blackColor] set];
        [Path setLineWidth:2.0];
        [Path stroke];
    }//end for loop
}*/

-(NSMutableArray*)middleLocation:(NSMutableArray*)midAry{
    //formale (x1 + x2)/2 (y1+ y2)/2
    int x1,x2,y1,y2;
    int midx,midy;
    //find ary locations
    int aryLength = (int) midAry.count;
// NSLog(@"start:%d",aryLength-2);
    if (midAry) {
        x1 = [[midAry objectAtIndex:aryLength-3] x];
        y1 = [[midAry objectAtIndex:aryLength-3] y];
        
        x2 = [[midAry objectAtIndex:aryLength-2] x];
        y2 = [[midAry objectAtIndex:aryLength-2] y];
        
        midx = (x1+x2)/2;
        midy = (y1+y2)/2;
        
        NSPoint tvarMousePointInView   = [self convertPoint:NSMakePoint(midx, midy+40) fromView:nil];
        myPoint * tvarMyPointObj       = [[myPoint alloc]initWithNSPoint:tvarMousePointInView];
        
        [midAry replaceObjectAtIndex:aryLength-2 withObject:tvarMyPointObj];
        
        return midAry;
    }
    return nil;
}
@end
