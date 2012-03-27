require 'test_helper'

class AccountNotifierTest < ActionMailer::TestCase
  test "confirm" do
    mail = AccountNotifier.confirm
    assert_equal "Confirm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "forgotten" do
    mail = AccountNotifier.forgotten
    assert_equal "Forgotten", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
