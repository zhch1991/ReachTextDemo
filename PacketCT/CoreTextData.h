//
//  CoreTextData.h
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>


@interface CoreTextData : NSObject
//用于保存由CTFrameParser类生成的CTFrameRef实例以及CTFrameRef实际绘制需要的高度。
//一个模型类，用于承载显示所需要的所有数据

@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray *imageArray;
@property (strong, nonatomic) NSArray * linkArray;


@end
