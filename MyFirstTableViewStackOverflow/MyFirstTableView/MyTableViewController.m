//
//  MyTableViewController.m
//  MyFirstTableView
//
//  Created by Tanguy Gourvez
//  Copyright © 2016 10s Apps. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyTableTableViewCell.h"
#import "MySectionHeaderView.h"

@interface MyTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic, nonnull) NSMutableArray *strings;

@end

@implementation MyTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.strings = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < 30; i++) {
        NSString *uuidString = [NSUUID UUID].UUIDString;
        NSMutableString *mutableString = [[NSMutableString alloc] initWithString:uuidString];
        if (i % 2 == 0) {
            [mutableString appendString:uuidString];
        }else if (i % 3 == 0) {
            [mutableString appendFormat:@"%@%@", uuidString, uuidString];
        }
        [self.strings addObject:mutableString];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MySectionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"MySectionHeaderView"];
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedSectionHeaderHeight = 50.0f;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
}

- (IBAction)deleteButtonWasTouched:(id)sender {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
        [indexSet addIndex:indexPath.row];
    }
    [self.strings removeObjectsAtIndexes:indexSet];
    
    [self.tableView deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.strings.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCellIdentifier" forIndexPath:indexPath];
    cell.titleLabel.text = @"Row : Testing header sections auto-layout";
    return cell;
}

#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MySectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MySectionHeaderView"];
    sectionHeaderView.titleLabel.text = [NSString stringWithFormat:@"Header %zd : %@", section, self.strings[section]];
    return sectionHeaderView;
}

@end
