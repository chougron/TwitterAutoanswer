require 'test_helper'

class SettingTest < ActiveSupport::TestCase

    test "should not save without name" do
        setting = Setting.new
        setting.value = "Value"
        assert_not setting.save
    end

    test "should not save without value" do
        setting = Setting.new
        setting.name = "Name"
        assert_not setting.save
    end

    test "should have unique name" do
        setting1 = Setting.new
        setting1.name = "Name"
        setting1.value = "Value"
        setting1.save

        setting2 = Setting.new
        setting2.name = "Name"
        setting2.value = "Value2"
        assert_not setting2.save
    end

    test "shoud save value in DB" do
        saved_value = "value"
        Setting.set("name", saved_value)

        setting = Setting.where(name: "name").first
        assert_equal setting.value, saved_value
    end

    test "should read value in DB" do
        saved_value = "value"
        Setting.set("name", saved_value)

        assert_equal Setting.get("name"), saved_value
    end

    test "should return default value if not in DB" do
        assert_equal Setting.get("NONEXISTINGVALUE"), false
        assert_equal Setting.get("NONEXISTINGVALUE", "default"), "default"
    end
    
end
