**ng_bighalo**

This is an avisynth script for subtitling encodes for http://tasvideos.org/

1) Avisynth's subtitler has a fixed halo width. This is problematic
with very large text, like the kind used with YouTube uploads.

2) Avisynth's subtitler is antialiased by default. Antialiasing is very
size dependant. A non-AA font is prefered for primary encodes, which
will likely be upsized on playback.

ng_bighalo solves the first issue, and freesub is a bitmap subtitler
that solves the second issue.

I've also included ng_sub which merges both functionality.
