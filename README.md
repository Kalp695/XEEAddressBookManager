![Alt text](/images/xee_01.png)

XEEAddressBookManager
=====================
XEEAddressBookManager is a helper class designed to alleviate the difficulties with handling address book contacts from user's device.

Usage
------------

```objc
XEEAddressBookManager* addressBookManager = [[XEEAddressBookManager alloc] init];

[addressBookManager allContactsFromAddressbook:^(NSArray *contacts) {
  NSLog(@"%d contacts retrieved.", contacts.count);
  for (XEEAddressBookContact* contact in contacts) {
    NSLog(@"%@ %@", contact.firstName, contact.lastName);
  }
}];
    
```

Contacts retrieved from device address book are encapsulated using XEEAddressBookContact model.
