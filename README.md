# Wry
Wry is a command-line client for App.net for Mac OS X 10.7+ (Lion), written in Objective-C.

## Installation
To install Wry, copy the wry executable to a directory on your path. You can obtain the wry executable by either downloading the latest version from the Wry homepage (<http://grailbox.com/wry>) or building it from source.

## Authorization
To use Wry, you must have an App.net account. Visit <https://join.app.net> to create an account, if you don't already have one.

Once you have an account, open a terminal and run:

    wry authorize

This will show you some instructions and then open a browser to the App.net login screen. Log in, and then you'll be asked whether you wish to allow Wry to access App.net on your behalf. Agree, and you'll be redirected to a Wry page that shows you an authorization code. It's kind of long, but you need all of it. Copy it to the clipboard and paste it back in the terminal window running Wry.

Wry stores your authorization code (*not* your App.net user name or password &mdash; Wry never has access to that) in your Mac OS X keychain. Never share this authorization code with anyone.

## Usage
Wry uses a command syntax similar to Git's; you type:

    wry <command> [params]

to run a command. Type:

    wry help

to show a list of commands and what they do. Type:

    wry help <command>

to get more detailed help about a particular command.

## Some Useful Commands
To view your stream, type:

    wry stream

This will show a list of posts from App.net. You can use standard command line pipes and commands to process the output from Wry. For example, to page through your stream, type:

    wry stream | less

You can post to App.net by typing:

    wry post "This is what I want to post"

Remember that your shell will interpret some characters, instead of passing them to Wry, so you may have to experiment a bit with escaping punctuation.

Note that the quotes are optional when posting or replying. This will post the same message as above:

    wry post This is what I want to post

To reply to a post, pass first the ID of the post that you wish to reply to, followed by the text of your reply. The post's ID is listed with the post when you view it, whether by itself or as part of a stream. To reply to post 1234, for example, type:

    wry reply 1234 This is my reply

Code Design

When designing the code, I had two guiding principles:

1. Make adding functionality easy. App.net is evolving rapidly, so adding new stuff should be simple.
2. Avoid switches in favor of Git-like commands. This not only makes using Wry more intuitive and memorable, it also means I can create Wry shell (or interactive console) that you can leave running. I haven't started work on that yet, but it's coming soon.


