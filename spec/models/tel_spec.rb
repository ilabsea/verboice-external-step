require File.expand_path("../../../models/tel.rb", __FILE__)
require File.expand_path("../../../models/operator.rb", __FILE__)
require "test/unit"
 
class TestTelSpec < Test::Unit::TestCase
 
  def test_prefix
    assert_equal('12', Tel.new('012999999').area_code)
    assert_equal('12', Tel.new('85512999999').area_code)
    assert_equal('12', Tel.new('+85512999999').area_code)

    assert_equal('10', Tel.new('010999999').area_code)
    assert_equal('10', Tel.new('85510999999').area_code)
    assert_equal('10', Tel.new('+85510999999').area_code)

    assert_equal(nil, Tel.new('+1109999999').area_code)
  end

  def test_code
    assert_equal(1, Tel.new('012999999').code)
    assert_equal(1, Tel.new('85512999999').code)
    assert_equal(1, Tel.new('+85512999999').code)

    assert_equal(2, Tel.new('010999999').code)
    assert_equal(2, Tel.new('85510999999').code)
    assert_equal(2, Tel.new('+85510999999').code)

    assert_equal(7, Tel.new('+1109999999').code)
  end
 
end