class TestContext < ApplicationController
  include ActionView::Helpers::TagHelper

  def request
    ActionDispatch::TestRequest.new
  end

  def link_to(*args)
    ActionView::Base.new.link_to(*args)
  end
end