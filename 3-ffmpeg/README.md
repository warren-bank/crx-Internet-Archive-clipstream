#### does not work

```bash
  convert-m3u8-to-mp4.bat [input_m3u8_url] [output_mp4_filepath]
```

* issue
  - ffmpeg warning: _Found duplicated MOOV Atom. Skipped it._
* related discussions
  - [1](https://stackoverflow.com/questions/44374790)
  - [2](https://video.stackexchange.com/questions/21315)
  - [3](https://stackoverflow.com/questions/7333232)

#### does work

```bash
  concat-mp4-files.bat [input_list_url] [output_mp4_filepath]
```

* notes
  - `.ffmpeg` file extension replaces `.m3u8` in URL requested from `serve`
  - this causes `serve` to run proxy middleware that is modified to return a response in a list format that will work with `ffmpeg` concatenation
