require 'test_helper'
require 'byebug'

class FotofetchTest < Minitest::Test

  def setup
    @ff = Fotofetch::Fetch.new
  end

  def test_that_it_has_a_version_number
    refute_nil ::Fotofetch::VERSION
  end

  def test_it_finds_image_links
    links = @ff.fetch_links("tesla model s", 5)

    assert_equal 5, links.count
    assert links.first[1].include?('.jpg')
  end

  def test_it_saves_sources_for_links
    link = @ff.fetch_links("mars", 1, true)
    source = link.values.first.split("/")[2]

    assert_equal source, link.keys.first
  end

  def test_it_can_save_an_image
    link = @ff.fetch_links("tesla", 1, true).values
    @ff.save_images(link, './')

    assert  File.exist?('image_0.jpg')
    File.delete('image_0.jpg')
  end

  def test_it_checks_image_size
    link = @ff.fetch_links("mars", 1, true).values
    dimensions = @ff.check_size(link.first)

    assert_equal 2, dimensions.count
  end


end
