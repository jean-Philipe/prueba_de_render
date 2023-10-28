require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one) 
    @user2 = users(:two)
    @calcetin = calcetins(:one)
    @like = Like.new(liker: @user1, calcetin: @calcetin)
  end

  test 'should be valid' do
    assert @like.valid?
  end

  test 'should require a liker' do
    @like.liker = nil
    assert_not @like.valid?
  end

  test 'should require a calcetin' do
    @like.calcetin = nil
    assert_not @like.valid?
  end

  test 'should enforce unique likes' do
    duplicate_like = @like.dup
    @like.save
    assert_not duplicate_like.valid?
  end

  test 'should have a liker' do
    assert_equal @user1, @like.liker
  end

  test 'should have a calcetin' do
    assert_equal @calcetin, @like.calcetin
  end



end
