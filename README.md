################################################################################
# File Name : README.txt
# Author : Mitch Winkle, AB4MW
# Version : 1.07
# Date : 27 July 2015
# License : Gnu GPL v3.0
# Description : README for the UIChat program
################################################################################
# Copyright 2015 Mitch Winkle, AB4MW 
# 
# UIChat is free software: you can redistribute it and/or modify it under the 
# terms of the GNU General Public License as published by the Free Software 
# Foundation, either version 3 of the License, or (at your option) any later 
# version. 
# 
# UIChat is distributed in the hope that it will be useful, but WITHOUT ANY 
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR 
# A PARTICULAR PURPOSE. See the GNU General Public License for more details. 
# 
# You should have received a copy of the GNU General Public License along with 
# UIChat (COPYING text file). If not, see http://www.gnu.org/licenses 
################################################################################
The UIChat program is a direct result of the fine work of the authors of FSQCall.

"FSQ was developed by Con Wassilieff ZL2AFP with the assistance of Murray 
Greenman ZL1BPU."  

More information about FSQ and FSQCall can be found at:

http://www.qsl.net/zl1bpu/MFSK/FSQweb.htm

In short, the model of the FSQCall program is one of simplicity, yet surprising
power.  It allows a pair of users, or a set of users (net), to communicate
directly and also allows passing of messages via an intervening third party. 
Messages may be written to disk.  A user may request your QTH information, or 
your software version, or any number of handy actions, all of which are handled
by the sofware automatically!

The most intriguing part of FSQCall for me is the SELCAL mode or Directed Mode.
In this mode, only messages destined for me are printed on my "screen".  This
makes for a neato way to use even a busy channel for chatting between two 
stations.  UIChat is built around the concept of FSQCall's SELCAL mode.  It also
allows the "allcall" and "cqcqcq" special identifiers in order to display 
multicast messages (just like FSQCall).

UIChat is a specific subset of the FSQCall action set.  Since it is designed to
work over Native Linux AX.25 using UI (Un-numbered Information) frames, there is
little need for a signal report (? action character).  At this time, the user is
greeted with a station status message of your choice.  The "*" action character
forces FSQCall to active mode if put into sleep mode.  This too is not required
for UIChat.  The speed action characters ( < and > ) are also not needed since
UIChat is not integrated to any one modem, but can use ANY modem that you can
connect to the Native Linux AX.25 stack (hint: there are a LOT of them!).  The
"|" alert action character is supported, but does not (at this time) create a
pop-up message for the receiving user, rather it moves down two blank lines and
surrounds the message with the word "ALERT" multiple times.  Lastly, the image
transfer function of FSQCall is not supported.

PRIMARY PURPOSE of UIChat

My thinking with the creation of UIChat was that the SELCAL functionality of it
is so useful; that it would be rather helpful on directed nets on VHF/UHF
as well as HF for that matter.  Having the ability to use digipeaters to extend
one's reach is also quite valuable in the VHF/UHF bands but can be used on HF
also using tools like N1URO's cross-port digipeater, axdigi.

NOTE: Use of a digipeater is a global setting.  It will be used for ALL 
communications if specified in the config file or at the command line.

The use of UIChat is not limited to AFSK or FSK however, since ANY modem which 
can present a KISS interface, even via TCP/IP on another computer, may be used
with UIChat.  This includes the venerable FLDIGI and it's KISS interface which
allows the use of a subset of it's modems to act as a KISS TNC to AX.25.  
Therefore, one may choose MFSK or BPSK instead of traditional "packet" modems.  
This gives the operator more flexibility, particularly on HF where band 
conditions may dictate the choice of modem type.

UIChat IS SPECIFIC TO NATIVE AX.25 ON LINUX ONLY

UIChat is not a purposefully created "new" program.  It is a set of shell 
scripts and configurations which integrate existing parts of the AX.25 toolset.
These scripts manage the incoming UI frames via the "axlisten" tool.  When a 
frame sent to 'UICHAT' is received, it is investigated to see if it is for my
call sign, for the "allcall" or "cqcqcq" identifiers.  If so, it's information 
is processed and displayed to the user based on the FSQCall rule sets.  If a 
response is required, that response is created and sent using the "beacon" tool.  
And the loop begins once again.

INHERENT LIMITATIONS IN UIChat

1. Frame size is limited to 255, and as yet, no mechanism for at least marking
frames as (1of2) or such has been coded.  This is at least a possibility 
however, and would give the receiving station a clue to a missing frame.
2. No image transfer capability is included.  
3. At the moment at least, there is no pop-up for the "|" action command.  The
current version runs only as a shell script in a terminal window (CLI).  I have 
used ALERT ALERT ALERT message ALERT ALERT ALERT as an alternate method.
4. I have not YET worked out the message storage for another station, but it 
does not seem overly complicated.
5. There is no built-in way to enable a signal report so I use that action
character, "?" as a station status message as stored in the config file or set
using the "status" command at the UICHAT> prompt.
6. In it's current form, it ONLY runs on Native AX.25 in Linux using the 
standard ax25-tools toolset.  I am exploring Java and/or Python as alternatives.

INSTALLING UIChat

Unpack the tarball and make scripts executable (<ver> is the version number) :

	tar xvzf UIChat-<ver>.tar.gz
	
Change to the newly created "uichat" directory and run the install script:
	cd UIChat-<ver>
	sudo ./install.sh
	
The install script is a full install for new installations and an upgrade for
those who have already installed UIChat.  The only thing you are warned to do
for an upgrade is to review the /etc/uichatd.template file for any changes to 
the /etc/uichatd/uichatd.conf format or added fields.
	
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
!!! Now edit the /etc/uichatd/uichatd.conf and make it your own. !!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
	sudo nano /etc/uichatd/uichatd.conf

You MUST at least set "mycall" and "axport" in the configuration file.

"mycall" should be set to lower case.  The program will change it anyway!

"axport" is the name of the port you wish to use from /etc/ax25/axports.  You may 
change it at any time from the program command line, but this value will remain
as your startup port for UIChat.

"digi" is a digipeater to use.  You may change the digi value at any time from 
the program and it's value will be stored back to the config file.  If you do 
not need a digipeater, leave this blank.

STATUS is the message returned when the "?" action is sent to you.  You may change
this value at any time from the program command line but it's value is not kept
for the next time you start the program.  The startup value is always 
"your_call_sign online..." In FSQCall, this is meant for a signal report, but no
such capability exists in AX.25's axlisten program, so UIChat just let's you set
your current status, such as:

	STATUS='ab4mw online...'  (the default startup value)
		or
	STATUS='ab4mw away from the shack...'
		or
	STATUS='ab4mw -- use # to leave me a message...'

SOUND_INTERVAL is the number of minutes between soundings, default is 15.
	
SOUND_TEXT is a short message used on your sounding transmission.  

Something like :

	your call and grid square : SOUND_TEXT='ab4mw FM17gf'
	
This is useful on HF to map propagation in combination with the heard list.

STATION is the message returned when the "&" action is sent to you.

QTH is the message returned when the "@" action is sent to you.

VER is the message returned when the "^" action is sent to you.


USING UIChat

To start UIChat, simply open a terminal window and type:

	sudo uichat 
	
You will be presented with a response that looks like :

	ab4mw@sova1:~# sudo uichat
	UIChat v1.07
	Hello Mitch.  Station ab4mw is using UICHat on axport hf.
	Enter ? for Help or quit to end the program
	
You will type commands at the "UICHAT> " prompt.
When messages or action commands arrive via the radio for your station, then
you will see them displayed in the terminal with an action command character
followed by "RX< " and then the information.  When you send text or a response
to an action command, it is preceded by "TX> " in the terminal.

	 RX< this message is for you
	@RX< ab4mw: QTH Request
	TX> ve1jot: Matoaca, VA USA FM17gf

	
