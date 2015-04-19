RSpec.shared_examples "a hashable element" do
  describe "#to_hash" do
    it 'should include required, value and error' do
      options.merge!(value: '', required: true)
      expect(subject.to_hash).to include(:required, :value, :error)
    end
  end
end