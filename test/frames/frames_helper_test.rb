require "test_helper"

class Turbo::FramesHelperTest < ActionView::TestCase
  test "frame with src" do
    assert_dom_equal %(<turbo-frame src="/trays/1" id="tray"></turbo-frame>), turbo_frame_tag("tray", src: "/trays/1")
  end

  test "frame with model src" do
    record = Message.create(id: "1", content: "ignored")

    assert_dom_equal %(<turbo-frame src="/messages/1" id="message"></turbo-frame>), turbo_frame_tag("message", src: record)
  end

  test "frame with src and target" do
    assert_dom_equal %(<turbo-frame src="/trays/1" id="tray" target="_top"></turbo-frame>), turbo_frame_tag("tray", src: "/trays/1", target: "_top")
  end

  test "frame with model argument" do
    record = Message.new(id: "1", content: "ignored")

    assert_dom_equal %(<turbo-frame id="message_1"></turbo-frame>), turbo_frame_tag(record)
  end

  test "frame with invalid argument should raise ArgumentError" do
    assert_raises ArgumentError, "ArgumentError: You must supply a frame id" do
      record = nil

      turbo_frame_tag(record)
    end

    assert_raises ArgumentError, "ArgumentError: You must supply a frame id" do
      record = []

      turbo_frame_tag(record)
    end

    assert_raises ArgumentError, "ArgumentError: You must supply a frame id" do
      record = ''

      turbo_frame_tag(record)
    end
  end

  test "string frame within a model frame" do
    record = Article.new(id: 1)

    assert_dom_equal %(<turbo-frame id="comments_article_1"></turbo-frame>), turbo_frame_tag(record, "comments")
  end

  test "string frame with non-record array" do
    assert_dom_equal %(<turbo-frame id="foo_1_2"></turbo-frame>), turbo_frame_tag(['foo', 1, 2])
  end

  test "block style" do
    assert_dom_equal(%(<turbo-frame id="tray"><p>tray!</p></turbo-frame>), turbo_frame_tag("tray") { tag.p("tray!") })
  end
end
