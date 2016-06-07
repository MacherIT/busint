require 'test_helper'

class ParticipacionTest < ActiveSupport::TestCase

  def setup
    @part = Participacion.new(deal_id: 1, user_id: 1)
  end

  test "debe ser valida" do
    assert @part.valid?
  end

  test "debe requerir un deal_id" do
    @part.deal_id = nil
    assert_not @part.valid?
  end
  
  test "debe requerir un user_id" do
    @part.user_id = nil
    assert_not @part.valid?
  end

end
