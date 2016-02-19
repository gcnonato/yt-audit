# Yt::Audit

Welcome! This is a Ruby library you can audit a YouTube channel.

The **source code** is available on [GitHub](https://github.com/Fullscreen/yt-audit) and the **documentation** on [RubyDoc](http://www.rubydoc.info/github/fullscreen/yt-audit/master/Yt/Audit).

[![Build Status](http://img.shields.io/travis/Fullscreen/yt-audit/master.svg)](https://travis-ci.org/Fullscreen/yt-audit)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/yt-audit/master.svg)](https://coveralls.io/r/Fullscreen/yt-audit)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/yt-audit.svg)](https://gemnasium.com/Fullscreen/yt-audit)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/yt-audit.svg)](https://codeclimate.com/github/Fullscreen/yt-audit)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/github/fullscreen/yt-audit/master/Yt/Audit)
[![Gem Version](http://img.shields.io/gem/v/yt-audit.svg)](http://rubygems.org/gems/yt-audit)


## Development

    $ bin/setup

    $ YT_API_KEY="123456789012345678901234567890123456789" rake
    $ open coverage/index.html

    $ yardoc
    $ open doc/index.html

## Usage

`run` method returns an array of objects. It uses channel title as brand name, and 10 recent videos of channel, currently.

```ruby
audit = Yt::Audit.new(channel_id: 'UCPCk_8dtVyR1lLHMBEILW4g')
# => #<Yt::Audit:0x007f94ec8050b0 @channel_id="UCPCk_8dtVyR1lLHMBEILW4g">
audit.run
# => [#<Yt::VideoAudit::InfoCard:0x007f94ec8c6f30 @videos=[...]>, #<Yt::VideoAudit::BrandAnchoring...>, #<Yt::VideoAudit::SubscribeAnnotation...>, #<Yt::VideoAudit::YoutubeAssociation...>, #<Yt::VideoAudit::EndCard...>]
```

You can call four available methods `total_count`, `valid_count`, `title`, and `description` from each `Yt::VideoAudit` object.

```ruby
video_audit = audit.run[0]
# => #<Yt::VideoAudit::InfoCard:0x007f94ec979ab8 @videos=[...]>
video_audit.total_count
# => 10
video_audit.valid_count
# => 10
video_audit.title
# => "Info Cards"
video_audit.description
# => "The number of videos with an info card"
```
