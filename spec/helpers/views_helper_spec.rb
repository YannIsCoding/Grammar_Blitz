require 'rails_helper'

describe ViewsHelper do
  describe "#percentage_for_day should return" do
    before(:each) do
      @user = create(:user)
      @exercice = create(:exercice)
    end

    it "100 if no tries for exercise/user pair" do
      expect(helper.percentage_for_day(@user, @exercice, 1)).to eq(100)
      expect(helper.percentage_for_day(@user, @exercice, 7)).to eq(100)
      expect(helper.percentage_for_day(@user, @exercice, 10_000)).to eq(100)
    end

    it "the correct percentage of successes/tries for the day" do
      create(:trial, user: @user, exercice: @exercice)
      create(:trial, user: @user, exercice: @exercice, success: true)
      expect(helper.percentage_for_day(@user, @exercice, 1)).to eq(50)
    end

    it "the correct percentage of successes/tries for the week" do
      create(:trial, user: @user, exercice: @exercice)
      before_yestrday = Time.zone.now.yesterday.yesterday
      create(:trial, user: @user, exercice: @exercice, success: true, created_at: before_yestrday)
      expect(helper.percentage_for_day(@user, @exercice, 1)).to eq(0)
      expect(helper.percentage_for_day(@user, @exercice, 7)).to eq(50)
    end

    it "the correct percentage of successes/tries for all of time" do
      create(:trial, user: @user, exercice: @exercice)
      before_yestrday = Time.zone.now.yesterday.yesterday
      create(:trial, user: @user, exercice: @exercice, success: true, created_at: before_yestrday)
      a_while_back = Time.zone.now - 1000.day
      create(:trial, user: @user, exercice: @exercice, success: true, created_at: a_while_back)
      expect(helper.percentage_for_day(@user, @exercice, 1)).to eq(0)
      expect(helper.percentage_for_day(@user, @exercice, 7)).to eq(50)
      expect(helper.percentage_for_day(@user, @exercice, 10_000)).to eq(66)
    end
  end
end
