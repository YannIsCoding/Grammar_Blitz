require 'rails_helper'

RSpec.describe Trial, type: :model do
  describe 'associations' do
      it { should belong_to(:progress_tracker) }
    end

  end

