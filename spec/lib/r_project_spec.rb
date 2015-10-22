require 'rails_helper'

describe RProject do
  describe '#packages' do
    subject { RProject.packages }

    it 'returns list of current packages' do
      expect(subject).to eq([])
    end
  end
end
