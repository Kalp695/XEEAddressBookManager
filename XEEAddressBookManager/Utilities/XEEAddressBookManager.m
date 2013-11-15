//
//  AddressBookManager.m
//  Unii
//
//  Created by Marko Strizic on 10/26/13.
//  Copyright (c) 2013 Andrija Cajic. All rights reserved.
//

#import "XEEAddressBookManager.h"
#import <AddressBook/AddressBook.h>

@implementation XEEAddressBookContact

@end

@implementation XEEAddressBookManager {
    BOOL _accessGranted;
    XEEBlockContacts _blockContacts;
}

#pragma mark -
#pragma mark Public

-(void) allContactsFromAddressbook:(XEEBlockContacts)contacts
{
    _blockContacts = contacts;
    [self addressBookAccess];
}

#pragma mark -
#pragma mark Private

-(void) addressBookAccess
{
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6 or greater
        ABAddressBookRef addressBook  = ABAddressBookCreateWithOptions(nil, nil);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            _accessGranted = granted;
            if (granted) {
                [self loadContactsFromAddressBook];
                CFRelease(addressBook);
            }else{
               //Show message to user
            }
        });
    }
    else { // we're on iOS 5 or older
        _accessGranted = YES;
        [self loadContactsFromAddressBook];
    }
}

- (void)loadContactsFromAddressBook
{
    NSMutableArray *contactsTemp = [NSMutableArray array];
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(Nil, Nil);
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex peopleCount = ABAddressBookGetPersonCount(addressBook);
    
    for (NSInteger i = 0; i < peopleCount; i++)
    {
        ABRecordRef contactRecord = CFArrayGetValueAtIndex(allPeople, i);
        
        if (!contactRecord) continue;
        
        CFStringRef abName = ABRecordCopyValue(contactRecord, kABPersonFirstNameProperty);
        CFStringRef abLastName = ABRecordCopyValue(contactRecord, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(contactRecord);
        CFDataRef imageData = ABPersonCopyImageDataWithFormat(contactRecord, kABPersonImageFormatOriginalSize);
        
        XEEAddressBookContact *contact = [[XEEAddressBookContact alloc] init];
        contact.firstName = (__bridge NSString *)(abName);
        contact.lastName = (__bridge NSString *)(abLastName);
        contact.fullName = (__bridge NSString *)(abFullName);
        contact.recordId = ABRecordGetRecordID(contactRecord);
        contact.image = [UIImage imageWithData:(__bridge NSData *)(imageData)];

        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSMutableArray *phoneNumbers = [NSMutableArray array];
        NSMutableArray *emails = [NSMutableArray array];
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(contactRecord, property);
            NSInteger valuesCount = 0;
            if (valuesRef) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                if (valuesRef) CFRelease(valuesRef);
                continue;
            }
            
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        [phoneNumbers addObject:(__bridge NSString*)value];
                        break;
                    }
                    case 1: {// Email
                        [emails addObject:(__bridge NSString*)value];
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        contact.phoneNumbers = phoneNumbers;
        contact.emails = emails;
        [contactsTemp addObject:contact];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
        if (imageData) CFRelease(imageData);
    }
    
    CFRelease(addressBook);
    if (allPeople) CFRelease(allPeople);
    
    if (_blockContacts) _blockContacts(contactsTemp);
    
}


@end
