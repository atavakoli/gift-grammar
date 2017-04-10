gift-grammar
============

A [PegJS][pegjs] grammar for the [Moodle GIFT quiz format][gift].

Support
-------

The grammar used currently does not support the following GIFT features:

- Categories (e.g. `$CATEGORY: tom/dick/harry`)
- Format changes (e.g. `[html]`, `[markdown]`, etc.)
- The `####general feedback` tag
- Backslash escapes (e.g. `\=`, `\n`, etc.)
- Anything related to Moodle plugins


[pegjs]: https://pegjs.org/
[gift]: https://docs.moodle.org/en/GIFT_format
