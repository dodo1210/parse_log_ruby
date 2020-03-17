require 'minitest/autorun'
require 'minitest/spec'
require_relative 'parse_log.rb'
 
describe Task1 do
  file = File.read('qgames.log')
  it "Geral method task1 not empty" do
    t = Task1.new
    assert(!t.task1(file).nil?, "Not nil")
  end

  it "Method endGame not is nil" do
    t = Task1.new
    assert(!t.endGame([],0,[],[],1).nil?,"Not nil")
  end

  it "Method eachN_kill not is nil" do
    t = Task1.new
    assert(!t.eachN_kill(file).nil?,"Not nil")
  end

  it "Method eachN_killed not is nil" do
    t = Task1.new
    assert(!t.eachN_killed(file).nil?,"Not nil")
  end
end

describe Bonus do
  it "Method bonus not empty" do
    t = Bonus.new
    file = File.read('qgames.log')
    assert(!t.bonus(file).nil?, "Not nil")
  end
end
