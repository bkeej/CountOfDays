CountOfDays
===========

This is a simple Haskell script that converts Gregorian dates into a full Mayan date, including the Long Count, the Haab, and the Cholq'ij (the last uses the Kaqchikel day names).

e.g., 12 Aug 2013 ==> 13.0.1.11.19, 12 Yaxk'in', 5 Kawoq

The only thing that might be of use are the functions in the module MayanCal.hs, which are tools for converting between Mayan and Julian dates. For instance, this module is at the core of the twitter bot I wrote that tweets the current Mayan date every morning at 8:01am.

https://twitter.com/CountOfDays