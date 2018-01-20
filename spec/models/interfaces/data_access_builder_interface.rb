RSpec.shared_examples "data access builder interface" do
  it "responds to .builds_object" do
    expect(described_class.respond_to?(:builds_object)).to eq(true)
  end
end