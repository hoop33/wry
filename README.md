# Wry &mdash; A command line client for App.net for Mac OS X 10.7+

# Note: App.net has shut down, rendering Wry useless. You can read more here: <https://en.wikipedia.org/wiki/App.net>

[![Build Status](https://travis-ci.org/hoop33/wry.svg?branch=master)](https://travis-ci.org/hoop33/wry)
[![Issues](https://img.shields.io/github/issues/hoop33/wry.svg)](https://github.com/hoop33/wry/issues)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)

## Description
Wry is a command-line client for App.net for Mac OS X 10.7+ (Lion), written in Objective-C.

App.net is a social network. Read more at <https://join.app.net/>.

## Important Note
If you're upgrading to Wry 1.3, you must reauthorize using:

```bash
$ wry authorize
```

Version 1.3 adds file access (upload, download, ls), and previous versions of Wry didn't request access to your files.

## License
Wry is released under the MIT license. See <http://opensource.org/licenses/MIT> for more information.

## Installation
To install Wry, copy the wry executable to a directory on your path. You can obtain the wry executable by either downloading the latest version from the Wry homepage (<http://grailbox.com/wry>) or building it from source.

## Why Wry?
Wry probably won't be your only App.net client, or even your main one, unless you live in tmux and terminal Vim. Most of your App.net interaction will likely happen in a GUI client. You may find yourself using Wry, however, to quickly create a post, find a user, or search a hashtag.

Wry's potential, however, lies in scripts or plugins. With Wry, you can create a cron job to create posts from a file. You can create a Vim plugin or Alfred workflow. You can create a monitoring job that sends you a text anytime someone mentions your company in a hashtag. Ruby, Perl, Python, whatever your scripting language — you can talk to App.net through Wry.

## Authorization
To use Wry, you must have an App.net account. Visit <https://join.app.net> to create an account, if you don't already have one.

Once you have an account, open a terminal and run:

```bash
$ wry authorize
```

This will show you some instructions and then open a browser to the App.net login screen. Log in, and then you'll be asked whether you wish to allow Wry to access App.net on your behalf. Agree, and you'll be redirected to a Wry page that shows you an authorization code. It's kind of long, but you need all of it. Copy it to the clipboard and paste it back in the terminal window running Wry.

Wry stores your authorization code (*not* your App.net user name or password &mdash; Wry never has access to that) in your Mac OS X keychain. Never share this authorization code with anyone.

## Usage
Wry uses a command syntax similar to Git's; you type:

```bash
$ wry <command> [params]
```

to run a command. Type:

```bash
$ wry help
```

to show a list of commands and what they do. Type:

```bash
$ wry help <command>
```

to get more detailed help about a particular command.

## Some Useful Commands
To view your stream, type:

```bash
$ wry stream
```

This will show a list of posts from App.net. You can use standard command line pipes and commands to process the output from Wry. For example, to page through your stream, type:

```bash
$ wry stream | less
```

You can post to App.net by typing:

```bash
$ wry post "This is what I want to post"
```

Remember that your shell will interpret some characters, instead of passing them to Wry, so you may have to experiment a bit with escaping punctuation.

Note that the quotes are optional when posting or replying. This will post the same message as above:

```bash
$ wry post This is what I want to post
```

To reply to a post, pass first the ID of the post that you wish to reply to, followed by the text of your reply. The post's ID is listed with the post when you view it, whether by itself or as part of a stream. To reply to post 1234, for example, type:

```bash
$ wry reply 1234 This is my reply
```

Again, quotes are optional around your reply text.

As of Wry 1.5, you now can send Private Messages and interact with Patter Rooms. To see a list of all your subscribed channels, type:

```bash
$ wry channels
```

To send a private message, type:

```bash
$ wry pm @username "This is a private message"
```

To read messages in the Patter Room with Channel ID 1234, for example, type:

```bash
$ wry messages 1234
```

To add to the discussion in the Patter Room with Channel ID 1234, type:

```bash
$ wry send 1234 "Hey, look -- I'm getting involved."
```

## Building Wry

Open `wry.xcodeproj` in Xcode and build.

## Code Design

When designing the code, I had two guiding principles:

1. Make adding functionality easy. App.net is evolving rapidly, so adding new stuff should be simple.
2. Avoid switches in favor of Git-like commands. This not only makes using Wry more intuitive and memorable, it also means I can create Wry shell (or interactive console) that you can leave running. I haven't started work on that yet, but it's coming soon.

To address these principles, each command is implemented as a class whose name matches the command line argument + the word "Command," in Pascal case. The class name for the "stream" command, for example, is `StreamCommand`. Each command class must implement the `WryCommand protocol`. The application then dynamically loads this class and runs it. The `Help` command finds all the commands dynamically as well.

This means that adding a command involves merely creating an appropriately named class and implementing the protocol.

To address code duplication, a `WryUtils` class implements common functionality. You'll see that the current commands delegate freely to this class.

The actual interaction with App.net rests in the `ADNService` class. This class calls the REST API, gets the results, and maps the JSON response to ADN object classes. To add more functionality, add the methods to `ADNService`, add the new mapping, if necessary, to `ADNMappingProvider`, and create a new command.

Wry uses formatters for output. To create a new formatter, write a class with the format name in all caps, followed by the word "Formatter," and make it conform to the `WryFormat` protocol. To create a formatter for comma-separated values, for example, create a class called:

```bash
CSVFormatter
```

To specify which formatter to use, pass its name on the command line with the --format flag, like this:

```bash
$ wry stream --format csv
```

This would show your stream in CSV format.

## Contributing to Wry

Wry uses the [git-flow](https://github.com/nvie/gitflow) branching model, so make your changes in feature branches and issue pull requests.

I'm using AppCode's formatter for the code, and I don't have it tweaked quite right yet. You'll notice, for example, that sometimes long lists of parameters aren't all on separate lines. I'll get that fixed (eventually).
