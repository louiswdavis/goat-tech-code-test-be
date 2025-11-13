# == Schema Information
#
# Table name: campaigns
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  status      :integer          default("active")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Campaign, type: :model do
  xcontext 'associations' do
    specify(:aggregate_failures) do
      is_expected.to have_many(:tasks).dependent(:destroy)
    end
  end

  context 'validations' do
    specify(:aggregate_failures) do
      is_expected.to validate_presence_of(:name)
      is_expected.to validate_length_of(:name).is_at_most(100)
    end
  end

  context 'enums' do
    specify(:aggregate_failures) do
      is_expected.to define_enum_for(:status).with_values({ active: 0, completed: 1, archived: 2 })
    end
  end
end
