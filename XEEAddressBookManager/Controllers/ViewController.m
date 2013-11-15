//
//  ViewController.m
//  XEEAddressBookManager
//
//  Created by Andrija Cajic on 15/11/13.
//  Copyright (c) 2013 Andrija Cajic. All rights reserved.
//

#import "ViewController.h"
#import "XEEAddressBookManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    XEEAddressBookManager* addressBookManager = [[XEEAddressBookManager alloc] init];
    [addressBookManager allContactsFromAddressbook:^(NSArray *contacts) {
        NSLog(@"%d contacts retrieved.", contacts.count);
        for (XEEAddressBookContact* contact in contacts) {
            NSLog(@"%@ %@", contact.firstName, contact.lastName);
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
