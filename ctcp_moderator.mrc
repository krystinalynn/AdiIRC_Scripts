//This script deliberately uses an invalid nick!ident@host format to prevent data leaks. 
//Do not alter it or you may run the risk of inadvertently leaking information to users on the network.
//This script can NEVER be used on mIRC as mIRC does not contain the proper commands and identifiers used by this script.
//
//You've been warned.

on *:LOAD: { 
  if (mIRC.exe isin $mircexe) { echo -at 4,0CTCP Moderator - FATAL ERROR: 4You are not using a supported client. This script was written for use in the 7AdiIRC4 client. It will not function in mIRC. }
  if (AdiIRC.exe isin $mircexe) { echo -at 1,2CTCP Moderator: To turn on the Moderator - use the command: /enable #ctcpmod } 
}

on *:START: { 
  if (AdiIRC.exe isin $mircexe) { 
    if ($group(#ctcpmod) == off) { echo -at 1,2CTCP Moderator: 4Disabled. } 
    if ($group(#ctcpmod) == on) { echo -at 1,2CTCP Moderator: 3Enabled. } 
  }
}

#ctcpmod off
ctcp *:*:*:{ 
  if (!$window(× CTCP Notifier ×)) {   /fakeraw :× CTCP Notifier ×!CLIENT SCRIPT@DO NOT REPLY!!! PRIVMSG $me :2,1CTCP Moderator - Verbose Log: This privmsg was set to you from the CTCP Moderator script. 4Do not reply. All CTCP attempts listed here have been blocked. Your client has not responded. This is a verbose log. It shows detailed information about a CTCP attempt. You should not close this privmsg. In the event you are CTCP flooded, information about the attack will be logged here. You can then turn this log over to an IRC Operator upon their request. } 
  /fakeraw :× CTCP Notifier ×!CLIENT SCRIPT@DO NOT REPLY!!! PRIVMSG $me :[ $+ $asctime $+ ] $nick ( $+ $fulladdress $+ ) attempted to perform a  $+ $1 $+  check on your client.
  if (!$window(@IPCatcher)) { //window -kei @IPCatcher | echo @IPCatcher 1,2CTCP Moderator - IP Catcher: This window will catch the IP addresses of anyone attempting to CTCP you. You should not close this window. In the event you are CTCP flooded, IPs will be logged here. You can then turn this log over to an IRC Operator upon their request. }
  echo -t @IPCatcher $gettok($fulladdress,1,33) is $gettok($fulladdress,2-,33)
  halt
}
#ctcpmod end
