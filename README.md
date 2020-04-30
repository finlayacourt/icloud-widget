# iCloud Storage Indicator v2 for [Übersicht](http://tracesof.net/uebersicht/)

<img src="https://github.com/finlayacourt/iCloud.widget/blob/master/screenshot.png">

A widget to show info about your current iCloud storage.

## Instructions

- Run `setup` by double clicking. You will be prompted to login to iCloud, and possibly a 2FA code. Will generate `auth.json` to store your authentication tokens. You will need to run this every time you change your iCloud password.
- Options for widget can be changed at the start of `chart.jsx`

## To do
- [ ] More info on hover
- [ ] Dark theme
- [ ] More secure storage of authentication tokens. Encrypted, or maybe keychain?

## iCloud API
For anyone who is interested
- Sends username and password to [idmsa.apple.com/appleauth/auth/signin]() to generate 2FA code.
- Sends username, password and 2FA code to [setup.icloud.com/setup/authenticate/$APPLE_ID$]()
- Returns `.plist` containing `dsid` and `mmeAuthToken`
- Use `dsid` and `mmeAuthToken` to request [p21-quota.icloud.com/quotaservice/external/osx/{dsid}/storageUsageInfo]()