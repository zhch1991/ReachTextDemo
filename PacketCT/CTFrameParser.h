//
//  CTFrameParser.h
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"

@interface CTFrameParser : NSObject
//用于生成最后绘制界面需要的CTFrameRef实例。一个排版类，用于实现文字内容的排版

//1
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

+ (CoreTextData *)parseTemplateFile:(NSArray *)dict config:(CTFrameParserConfig*)config;
@end