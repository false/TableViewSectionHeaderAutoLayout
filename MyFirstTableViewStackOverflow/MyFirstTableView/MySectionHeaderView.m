//
//  MySectionHeaderView.m
//  MyFirstTableView
//
//  Created by Tanguy Gourvez
//  Copyright © 2016 10s Apps. All rights reserved.
//

#import "MySectionHeaderView.h"

@interface MySectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *theContentView;

@end

@implementation MySectionHeaderView

- (UIView *)contentView {
    return self.theContentView;
}

@end
