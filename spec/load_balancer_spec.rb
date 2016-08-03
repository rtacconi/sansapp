require 'rspec'
require 'faraday'

describe 'Load Balancer' do
  it 'does round-robin' do
    # this test is not sensitive to the order of the output
    # but it checks if requests are alternated between the two backends
    (1..10).each do
      first = Faraday.get('http://localhost:8080/').body
      second = Faraday.get('http://localhost:8080/').body
      first_and_second = [ first, second ]
      # check if both servers are respoding
      expect(first_and_second).to include("Hi there, I'm served from app-node1-ubuntu-1604!")
      expect(first_and_second).to include("Hi there, I'm served from app-node2-ubuntu-1604!")
      # check alternation
      expect(first).not_to eq(second)
      # repeat this ten times
    end
  end
end
