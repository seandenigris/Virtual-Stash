# Virtual Stash
	
TLDR: Picture GnuCash, minus the application stovepipe, running on GToolkit (Smalltalk)
	
# Overview
	
NB. This section is an export of the class comment of `BaselineOfVirtualStash`. When viewed from inside the system, it is live, dynamic and beautiful. "Just the markdown" only gives you a taste. We suggest you dive in and view the documentation as it was intended as quickly as possible - it will be more enjoyable and productive!


	
# Installation
In GToolkit (preferably) or Pharo (v. 9 best supported at time of writing), do the following:

```smalltalk
[
EpMonitor current disable.
[ Metacello new
	baseline: 'VirtualStash';
	repository: 'github://seandenigris/Virtual-Stash';
	"onConflict: [ :ex | ex allow ];"
	load ] ensure: [ EpMonitor current enable ].

] fork.
#VirtualStashDB asClass restoreLastBackup.
#BaselineOfVirtualStash asClass setUpIDE.
```
N.B. you only have to do the outer fork if on GT and you want the UI to stay responsive during the load.

# Disclaimer

This project is part of a ~20 year (as of 2021) exploration of the [Dynabook](https://github.com/seandenigris/Dynabook) idea (a la Alan Kay). It's intensely personal and opinionated and I've open sourced it due to repeated requests. Use at your own risk. Any part may change at any time. I'm happy to give support when I have time in the form of explanations, but do not expect me to implement any particular feature, or even accept PRs if they don't feel right. That said, I'm happy to have anyone along on the journey :)
# License Explanation
The license is MIT. However, my original intent was to release my Dynabook libraries under a copy far left license (free use for cooperatives, but negotiated licenses for those utilizing paid labor for profit). I love sharing any work I do, but am disgusted by the propect that (especially multi-billion-dollar) corporations will exploit my work for free, especially toward ends with which I don't philosophically agree. However, after many discussions with colleagues, it appears that at this moment there is just no way to protect one's work from parasites without effectively keeping it from everyone. Even GPL, which doesn't even come close to "solving" the problem stated above, seems enough to put off most people. In closing, now that my intentions are clear, I request the following from any entity utilizing wage labor or selling for profit who uses my work:
1. Attribution
2. Pay for what you use, or don't use it

While there may be no legal means for me to enforce the above given that this code is released under MIT, my intentions should be clear; violate the above at risk to your own conscience.
