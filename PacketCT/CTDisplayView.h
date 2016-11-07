//
//  CTDisplayView.h
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"
@interface CTDisplayView : UIView
//持有CoreTextData类的实例，负责将CTFrameRef绘制到界面上。
//一个显示用的类，仅负责显示内容，不负责排版

@property (nonatomic, strong) CoreTextData *data;

@end
