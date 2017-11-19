# docker-nginx-rtmp

The nginx docker image with rtmp module based on gentoo. HLS plugin also is configured.

## setup

There are two ways
- docker build
  ```
    # docker build -t namespace/nginx-rtmp:gentoo .
    # docker run --rm -v ./hls:/hls -P namespace/nginx-rtmp:gentoo
  ```
- docker-compose
  ```
    # docker-compose up
  ```    

Now you have to push your stream to nginx. E.g. use gstreamer pipeline:
```
  # gst-launch-1.0 filesrc location="file.mkv" ! { ... } ! rtmpsink location="rtmp://localhost:XXXXX/play/live live=1"
```
Your hls stream will be available on http://localhost:YYYYY/play.m3u8, you could play it with browser.

_XXXXX and YYYYY are ports exposed by docker, with '-P' options they will be random_