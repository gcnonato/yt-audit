require 'yt'
require 'yt/annotations'

module Yt
  module Audit
    # Audit any info card of a video
    # @param [String] video_id the video to audit.
    # @return [Boolean] if the video has any info card.
    def self.has_info_cards?(video_id)
      Yt::Annotations.for(video_id).any? do |annotation|
        annotation.is_a? Yt::Annotations::Card
      end
    end

    # Audit brand anchoring of a video
    # @param [String] video_id the video to audit.
    # @param [String] brand name of the video to audit.
    # @return [Boolean] if the video title includes brand name.
    def self.has_brand_anchoring?(video_id, brand)
      video_title = Yt::Video.new(id: video_id).title
      !!video_title[/#{brand}/i]
    end

    # Audit any subscribe annotation of a video
    # @param [String] video_id the video to audit.
    # @return [Boolean] if the video has any link to subscribe in the annotations.
    def self.has_subscribe_annotations?(video_id)
      Yt::Annotations.for(video_id).any? do |annotation|
        annotation.link && annotation.link[:type] == :subscribe
      end
    end

    # Audit youtube association of a video
    # @param [String] video_id the video to audit.
    # @return [Boolean] if the video description has link to its own channel.
    def self.has_link_to_own_channel?(video_id)
      video = Yt::Video.new(id: video_id)
      video.description.split(' ')
           .select {|word| Yt::URL.new(word).kind == :channel }
           .any? {|link| Yt::Channel.new(url: link).id == video.channel_id }
    end

    # Audit end cards of a video
    # @param [String] video_id of the video to audit.
    # @return [Boolean] if the video has any annotation, other than info cards,
    #   with a link in it, at the end of video, stays for more than 5 seconds.
    def self.has_end_cards?(video_id)
      video_duration = Yt::Video.new(id: video_id).duration
      Yt::Annotations.for(video_id).any? do |annotation|
        !annotation.is_a?(Yt::Annotations::Card) && annotation.link &&
          (annotation.ends_at.floor..annotation.ends_at.ceil).include?(video_duration) &&
          video_duration - annotation.starts_at > 5
      end
    end
  end
end
