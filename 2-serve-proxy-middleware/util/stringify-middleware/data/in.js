const middleware = function($, proxy_url, original_url_path) {
  let data
  data = $('input.js-tv3-init[value]').attr('value')
  data = JSON.parse(data)
  data = data['TV3.clipstream_clips']

  const format_default = 'm3u8'
  const format_regex   = /^.*\.(m3u8|m3u|nget|ffmpeg)$/i
  const format         = format_regex.test(original_url_path) ? original_url_path.replace(format_regex, '$1').toLowerCase() : format_default

  const response = []

  switch(format) {
    case 'm3u8':
      {
        response.push(...[
          '#EXTM3U',
          '#EXT-X-VERSION:6',
          '#EXT-X-TARGETDURATION:60',
          '#EXT-X-PLAYLIST-TYPE:VOD'
        ])

        const duration_regex = /^.*t=(\d+)\/(\d+).*$/
        let match, time_start, time_end, time_duration_secs

        data.forEach(url => {
          match = duration_regex.exec(url)
          if (match) {
            time_start = parseInt(match[1], 10)
            time_end   = parseInt(match[2], 10)

            time_duration_secs = time_end - time_start

            response.push('#EXTINF:' + time_duration_secs)
          }
          response.push(url)
        })

        response.push('#EXT-X-ENDLIST')
      }
      break
    case 'm3u':
      {
        response.push(...data)
      }
      break
    case 'nget':
      {
        data.forEach((url, index) => {
          response.push(`${url}\t${index + 1}.mp4`)
        })
      }
      break
    case 'ffmpeg':
      {
        data.forEach(url => {
          response.push(`file '${url}'`)
        })
      }
      break
  }

  $.html = () => response.join("\n")
}

module.exports = {
  "proxyMiddleware": [
    {
      "engine":        "text",
      "source":        "https://archive.org/details/",
      "type":          "html",
      "middleware":    middleware,
      "terminal":      true
    }
  ]
}
