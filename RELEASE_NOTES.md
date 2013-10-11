# Release Notes

## Version 1.7 (coming)
* Change user following/followed arrows to <--> and omit if no relationship
* For links that have no link text, don't display URL twice
* Display version information for wry -v
* Display help information for wry -h
* Allow reposting a repost
* Add name of client to post display
* Add new search API
--
* Colorize output
* Make separator between posts et al configurable
* Options for posts that are too long: ask before truncating, truncate, split into multiple, or reject
* Support defaults for all flags in wry.plist
* Add config command for viewing and setting defaults
* Add license file and license statement to version command (MIT licensed)
* Fix: multi-line markdown links don't work

## Version 1.6 (6/19/2013)
* Add -r/--reverse flag to reverse order of output
* Add posting/replying/messaging from stdin (Thanks, @jws!)
* Add external editor support for posting/replying/messaging
* Add -a/--annotations flag for pulling annotations
* Add URL/Short URL and public/private to output for Files
* Add chmod command to change public/private status for a File
* Add mv command to rename a File
* Add hashtags and links to Post output
* Add support for creating links in posts, replies, and messages using Markdown: [link text])(http://example.com)

## Version 1.5 (5/14/2013)
* Add Private Message support
* Add Patter Room support
* Add general Channel and Message support
* Fix: retrieve user by ID not working

## Version 1.4.1 (5/1/2013)
* Change multi-user support to use actual ADN user IDs instead of arbitrary strings in keychain
* Add commands to delete authorized users and set default user
* Allow @username or username whenever a username is passed (except find)

## Version 1.4 (4/29/2013)
* Add pretty-printing for JSON
* Remove requirement for CocoaPods
* Add multi-user support

## Version 1.3 (4/12/2013)
* Add "commands" command
* Add "ls" command
* Add "upload" command
* Add "download" command
* Add "files" to scope of requested access from App.net

## Version 1.2 (4/7/2013)
* Add Why Wry? section to README
* Add images for App.net directory
* Add formatters, including Alfred and JSON
* Upgrade SSKeychain to 1.0.2
* Add credit for SSKeychain to version output
* Fix: Show error message, if any, returned from App.net
* Add information for formatters to README
* Improve Help output for flags

## Version 1.1 (4/4/2013)
* Implement -c/--count flag
* Fix: check for nil before appending Bio

## Version 1.01 (4/1/2013)
* Fix: Add .html to end of callback URL

## Version 1.0 (4/1/2013)
* Initial release
