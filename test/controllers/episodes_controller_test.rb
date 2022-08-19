require "test_helper"

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @episode = episodes(:one)
  end

  test "should get index" do
    get episodes_url
    assert_response :success
  end

  test "should get new" do
    get new_episode_url
    assert_response :success
  end

  test "should create episode" do
    assert_difference("Episode.count") do
      post episodes_url, params: { episode: { affiliate_link: @episode.affiliate_link, book_id: @episode.book_id, creator_id: @episode.creator_id, duration: @episode.duration, mp3_url: @episode.mp3_url, preview_url: @episode.preview_url, title: @episode.title } }
    end

    assert_redirected_to episode_url(Episode.last)
  end

  test "should show episode" do
    get episode_url(@episode)
    assert_response :success
  end

  test "should get edit" do
    get edit_episode_url(@episode)
    assert_response :success
  end

  test "should update episode" do
    patch episode_url(@episode), params: { episode: { affiliate_link: @episode.affiliate_link, book_id: @episode.book_id, creator_id: @episode.creator_id, duration: @episode.duration, mp3_url: @episode.mp3_url, preview_url: @episode.preview_url, title: @episode.title } }
    assert_redirected_to episode_url(@episode)
  end

  test "should destroy episode" do
    assert_difference("Episode.count", -1) do
      delete episode_url(@episode)
    end

    assert_redirected_to episodes_url
  end
end
