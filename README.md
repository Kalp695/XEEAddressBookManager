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


Contact
================

Follow XEETech on Twitter (<a href="https://twitter.com/XEE_Tech">XEE Tech</a>).

Connect with us on LinkedIn (<a href="http://www.linkedin.com/company/xee-tech">@XEE_Tech</a>).


License
================
XEEPluralizer is available under the MIT license. See the LICENSE file for more info.
