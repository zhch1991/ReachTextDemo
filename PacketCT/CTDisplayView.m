//
//  CTDisplayView.m
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"
#import "CoreTextUtils.h"

@interface CTDisplayView()<UIGestureRecognizerDelegate>

@end

@implementation CTDisplayView

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//
//    if (self.data) {
//        CTFrameDraw(self.data.ctFrame, context);
//    }
//}



//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setupEvents];
//    }
//    return self;
//
//}
//
//
//-(void)setupEvents
//{
//    self.userInteractionEnabled = YES;
//
//    UIGestureRecognizer *tapRecognize = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
//    tapRecognize.delegate = self;
//    [self addGestureRecognizer:tapRecognize];
//
//}
//
//-(void)tapped:(UIGestureRecognizer *)tap
//{
//    CGPoint point = [tap locationInView:self];
//
//    [self.data.imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CoreTextImageData *imageData = (CoreTextImageData *)obj;
//
//        CGRect imageRect = imageData.imagePosition;
//        CGPoint imagePosition = imageRect.origin;
//        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
//        CGRect realRect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
//        if (CGRectContainsPoint(realRect, point)) {
//            NSLog(@"ddkfldkfdl==========");
//            stop = YES;
//        }
//    }];
//
//}




-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
    
    [self.data.imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CoreTextImageData *imageData = (CoreTextImageData *)obj;
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    //获取UITouch对象
    UITouch *touch = [touches anyObject];
    //获取触摸点击当前view的坐标位置
    CGPoint location = [touch locationInView:self];
    [self.data.imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CoreTextImageData *imageData = (CoreTextImageData *)obj;
        
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect realRect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        if (CGRectContainsPoint(realRect, location)) {
            NSLog(@"我是图片==========");
            stop = YES;
        }
    }];
    
    CoreTextLinkData *linkData = [CoreTextUtils touchLinkInView:self atPoint:location data:self.data];
    if (linkData) {
        NSLog(@"我是链接，链接啊=========");
        return;
    }
    
}

@end

