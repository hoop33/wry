//
//  WryComposer.m
//  wry
//
//  Created by Rob Warner on 6/14/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryComposer.h"
#import "WrySettings.h"
#import "WryApplication.h"
#import "WryUtils.h"
#import "EditorSetting.h"

@interface WryComposer ()
- (NSString *)shell;
- (NSString *)editor;
- (NSString *)tempFileName;
@end

@implementation WryComposer

+ (NSString *)help {
  return @"If you don't supply text, an editor will launch to let you compose your text.\n"
    "Type your text and quit your editor to proceed. This lets you avoid all shell\n"
    "quoting. You can also pipe input from other commands to create your text.\n"
    "\n"
    "The editor used will be one of these, in this order:\n"
    "  1. The value for 'editor' in com.grailbox.wry.plist\n"
    "  2. $WRY_EDITOR\n"
    "  3. $VISUAL\n"
    "  4. $EDITOR\n"
    "  5. vi\n"
    "\n"
    "Note: You can set the editor to STDIN to type your text in the terminal, and\n"
    "press ^D to finish typing.";
}

- (NSString *)compose {
  NSString *text = nil;
  NSString *editor = [self editor];
  if ([WryApplication application].interactiveIn && ![[editor lowercaseString] isEqualToString:@"stdin"]) {
    NSString *tempFileName = [self tempFileName];
    if (tempFileName != nil) {
      [self setUpTempFile:tempFileName];
      NSString *path = [self shell];
      const char *cpath = [path UTF8String];

      NSArray *args = @[@"-i", @"-c", [NSString stringWithFormat:@"%@ %@", editor, tempFileName]];
      const char *cargs[args.count + 1];
      size_t i = 0;
      for (NSString *arg in args) {
        cargs[i++] = [arg UTF8String];
      }
      cargs[i] = NULL;

      pid_t childPID = fork();
      if (!childPID) {
        execvp(cpath, (char **) cargs);

        assert(false && "failed to exec editor");
      }

      /* Wait till child process exits. */
      pid_t result = 0;
      while (result >= 0 && errno != EINTR) {
        result = waitpid(childPID, NULL, 0);
      }

      text = [self filterComments:[[NSString alloc] initWithContentsOfFile:tempFileName
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil]];
      [[NSFileManager defaultManager] removeItemAtPath:tempFileName error:nil];
    }
  }

  // If it's non-interactive, or if we had any issues with editor or file, fall through
  // and create from stdin
  if (text == nil) {
    NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
    NSData *textData = [input readDataToEndOfFile];
    text = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
  }
  return [text hasSuffix:@"\n"] ? [text substringToIndex:text.length - 1] : text;
}

- (NSString *)shell {
  return [[[NSProcessInfo processInfo] environment] objectForKey:@"SHELL"];
}

- (NSString *)editor {
  NSDictionary *environment = [[NSProcessInfo processInfo] environment];
  NSString *editor = [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[EditorSetting class]]];
  if (editor.length == 0) editor = [environment objectForKey:@"WRY_EDITOR"];
  if (editor.length == 0) editor = [environment objectForKey:@"VISUAL"];
  if (editor.length == 0) editor = [environment objectForKey:@"EDITOR"];
  if (editor.length == 0) editor = @"vi";
  return editor;
}

- (void)setUpTempFile:(NSString *)tempFileName {
  NSString *contents = [NSString stringWithFormat:@"\n%@", [self comment]];
  [contents writeToFile:tempFileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)comment {
  return @"# Please enter the text for your post or message. Lines starting\n"
    @"# with '#' will be ignored, and empty text aborts the post or message.\n"
    @"#";
}

- (NSString *)filterComments:(NSString *)text {
  if (text == nil || text.length == 0) {
    return text;
  }
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^#.*$\r?\n?"
                                                                         options:NSRegularExpressionAnchorsMatchLines
                                                                           error:nil];
  return [regex stringByReplacingMatchesInString:text
                                         options:0
                                           range:NSMakeRange(0, text.length)
                                    withTemplate:@""];
}

// With help from http://www.cocoawithlove.com/2009/07/temporary-files-and-folders-in-cocoa.html
- (NSString *)tempFileName {
  NSString *tempFileName = nil;
  NSString *template = [NSTemporaryDirectory() stringByAppendingPathComponent:@"wry.XXXXXX"];
  const char *templateCString = [template fileSystemRepresentation];
  char *tempFileNameCString = (char *) malloc(strlen(templateCString) + 1);
  strcpy(tempFileNameCString, templateCString);
  int fileDescriptor = mkstemp(tempFileNameCString);
  if (fileDescriptor != -1) {
    tempFileName = [[NSFileManager defaultManager] stringWithFileSystemRepresentation:tempFileNameCString
                                                                               length:strlen(tempFileNameCString)];
  }
  free(tempFileNameCString);
  return tempFileName;
}

@end
