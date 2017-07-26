# clock4blind

This is a very primitive iOS app that reads current date and time when screen is touched anywhere on the phone.
I built it for my grandma who is almost blind and can't read text.
It works best with screen timeout set to NEVER and the guided access enabled, so that it stays always on top.

It reads current date with the current locale voice.
It reads full date once touched, and then, if touched within a minute, it reads only time.
It has 4 sec protection against double-tapping.

Future possible improvements:
- hide status bar
- use landscape mode
- add settings for speed, voice, whether to read year, date, etc., invoked by some special gesture (to avoid accidental invocation).

Hope it helps someone else.
