RSpec.shared_examples "decorator interface" do
  
  it "responds to #to_model" do
    expect(described_class.decorate(double).respond_to?(:to_model)).to eq(true)
  end

  it "responds to #class" do
    expect(described_class.decorate(double).respond_to?(:class)).to eq(true)
  end

  it "responds to .decorate" do
    expect(described_class.respond_to?(:decorate)).to eq(true)
  end
end