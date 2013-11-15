//
//  AddressBookManager.h
//  Unii
//
//  Created by Marko Strizic on 10/26/13.
//  Copyright (c) 2013 Andrija Cajic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XEEAddressBookContact : NSObject

@property (nonatomic,assign) NSInteger recordId;
@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSString *fullName;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSArray *phoneNumbers;
@property (nonatomic,strong) NSArray *emails;

@end


typedef void (^XEEBlockContacts)(NSArray *contacts);


/**
 Helper class used for retrieving device contacts.
 */
@interface XEEAddressBookManager : NSObject


-(void) allContactsFromAddressbook:(XEEBlockContacts)contacts;

@end
