//
//  NavController.m
//  DoubanAPIEngineDemo
//
//  Created by Lin GUO on 3/26/12.
//  Copyright (c) 2012 douban.inc. All rights reserved.
//

#import "NavController.h"
#import "GetEventController.h"
#import "WebViewController.h"
#import "DOUService.h"


@implementation NavController

@synthesize tableView = tableView_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"演示";
  }
  return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {

}


- (void)viewDidUnload {
  self.tableView = nil;
  [super viewDidUnload];
}


- (void)dealloc {
  [tableView_ release];
  [super dealloc];
}


#pragma mark -
#pragma mark UITableViewDataSource's methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString* cellIdentifier = @"TableViewCell";
  
  UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                   reuseIdentifier:cellIdentifier] autorelease];
  }
  
  NSUInteger row = [indexPath row];
  if (row == 0) {
    cell.textLabel.text = @"登录";    
  }
  else if (row == 1) {
    cell.textLabel.text = @"Get 活动信息";    
  }
  else if (row == 2) {
    cell.textLabel.text = @"Post 照片";
  }
  
  return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate's methods


- (void)tableView:(UITableView *)tableView 
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if ([indexPath row] == 0) {
    NSString *urlStr = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=code", [DOUService apiKey], [DOUService redirectUrl]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    UIViewController *webViewController = [[WebViewController alloc] initWithRequestURL:url];
    [self.navigationController pushViewController:webViewController animated:YES];
  }
  else if ([indexPath row] == 1) {
    UIViewController *getEventController = [[GetEventController alloc] initWithNibName:@"GetEventController" 
                                                                                bundle:nil];
    [self.navigationController pushViewController:getEventController animated:YES];     
  }
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
