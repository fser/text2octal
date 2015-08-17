text2octal
==========

Converts a unix "ls -l" representation in octal mode.


Usage
-----

perl text2octal.pl rights_string [rights_string, ... ]

Example
-------
```
$ perl text2octal.pl rwxrwxrwx drwxr-sr-x drwxrws--- d-ws----wt
rwxrwxrwx 777
drwxr-sr-x 2755
drwxrws--- 2770
d-ws----wt 5303
```
