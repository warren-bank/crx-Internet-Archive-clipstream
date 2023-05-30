### [Internet Archive - Clipstream Player](https://github.com/warren-bank/crx-Internet-Archive-clipstream/tree/master)

#### Background:

The easiest way to describe what this project does is to explain how it came to be..

* every Sunday morning, a family member ask to watch ["State of the Union"](https://www.cnn.com/shows/state-of-the-union) on [CNN's video-on-demand website](http://qa.go.cnn.com/vod)
* for the past few weeks, this series hasn't been listed there..<br>so its most recent episode has been unavailable
* looking for an alternate source from which to stream,<br>I discovered that the Internet Archive has a very complete collection of news programs
  - [all news programs](https://archive.org/details/@tv?&sort=-publicdate&page=1)
  - [all "State of the Union" episodes](https://archive.org/details/@tv?query=state+of+the+union)
* I found the episode that I wanted to stream
  - [one "State of the Union" episode](https://archive.org/details/CNNW_20230528_160000_State_of_the_Union_With_Jake_Tapper_and_Dana_Bash)
  - [its list of "restricted" files](https://archive.org/download/CNNW_20230528_160000_State_of_the_Union_With_Jake_Tapper_and_Dana_Bash)
* but, there was a minor roadblock
  - its availability is: "stream only"
  - the "restricted" .mp4 video file is served in 60 second segments
    * each segment is an individual .mp4 video file,<br>rather than .ts
* inspecting the html page source for the episode,<br>I found that all of the URLs for the individual .mp4 video segments can be easily extracted

- - - -

#### Design Strategy v1:

In 2x parts:

1. [userscript](https://github.com/warren-bank/crx-Internet-Archive-clipstream/raw/master/1-webmonkey-userscript/Internet-Archive-clipstream.user.js) that runs in a web browser
   - detects Internet Archive pages for videos that are broken into segments
   - constructs a new URL to a local webserver that will produce an .m3u8 HLS manifest that contains the URL for each of the .mp4 video segments
   - redirects the browser to a video player

2. local webserver
   - reconstructs the URL for the original Internet Archive page
   - proxies this URL
   - passes the HTML response to [middleware](https://github.com/warren-bank/node-serve/tree/master/lib/serve-handler#proxymiddleware-array)
     * produce an .m3u8 HLS manifest
   - returns a response
     * sets the `content-type` header to that of an HLS manifest
     * adds the .m3u8 HLS manifest to the data payload of the body

#### Issues w/ Design Strategy v1:

* because each video segment is an .mp4 video file
  - Android [`ExoPlayer`](https://github.com/google/ExoPlayer) refuses to play the .m3u8 HLS manifest
  - [`ffmpeg`](https://github.com/FFmpeg/FFmpeg) fails to convert the .m3u8 to .mp4
    * no error
    * warning: _Found duplicated MOOV Atom. Skipped it._
    * outcome: after downloading all .mp4 video segments,<br>the combined .mp4 video file only has the length of 1x segment

- - - -

#### Design Strategy v2:

Minor tweaks:

* update the proxy middleware to output alternate playlist formats,<br>based on the file extension in the URL request:
  - `m3u8`
  - `m3u`
    * produces a simple list of URLs,<br>one URL per line
    * Android [`ExoAirPlayer`](https://github.com/warren-bank/Android-ExoPlayer-AirPlay-Receiver) plays each .mp4 video segment in order
  - `nget`
    * produces a simple list of URLs,<br>one URL per line,<br>and each line appends a sequentially numbered .mp4 filename
    * for use by [`nget`](https://github.com/warren-bank/node-request-cli) as an `--input-file`
  - `ffmpeg`
    * produces a simple list of URLs,<br>one single-quoted URL per line,<br>and each line prepends: `file `
    * for use by the [`ffmpeg concat demuxer`](https://trac.ffmpeg.org/wiki/Concatenate#demuxer)

#### Status of Design Strategy v2:

* everything is working

- - - -

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
