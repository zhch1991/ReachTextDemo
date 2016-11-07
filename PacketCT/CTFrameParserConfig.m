//
//  CTFrameParserConfig.m
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

-(instancetype)init
{
    if (self = [super init]) {
        _width = 100;
        _fontSize = 15;
        _lineSpace = 8;
        _textColor = [UIColor blackColor];
    }
    return self;
}
@end
