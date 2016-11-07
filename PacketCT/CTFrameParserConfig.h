//
//  CTFrameParserConfig.h
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTFrameParserConfig : NSObject
//用于配置绘制的参数，例如：文字颜色，大小，行间距等。一个配置类，用于实现一些排版时的可配置项
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;

@end