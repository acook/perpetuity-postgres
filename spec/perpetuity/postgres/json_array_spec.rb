require 'perpetuity/postgres/json_array'

module Perpetuity
  class Postgres
    describe JSONArray do
      it 'serializes empty arrays' do
        JSONArray.new([]).to_s.should == "'[]'"
      end

      it 'serializes arrays of numeric values' do
        JSONArray.new([1,2,3]).to_s.should == "'[1,2,3]'"
      end

      it 'serializes arrays of strings' do
        JSONArray.new(%w(foo bar baz)).to_s.should == %q{'["foo","bar","baz"]'}
      end

      it 'serializes arrays of hashes' do
        JSONArray.new([{a: 1}, {b: 2}]).to_s.should == %q{'[{"a":1},{"b":2}]'}
      end

      it 'serializes arrays of JSONHashes' do
        JSONArray.new([JSONHash.new(a: 1)]).to_s.should == %q{'[{"a":1}]'}
      end

      it 'serializes arrays of arrays' do
        JSONArray.new([[1], ['foo']]).to_s.should == %q{'[[1],["foo"]]'}
      end

      it 'serializes elements of arrays' do
        JSONArray.new([1,'a']).to_s.should == %q{'[1,"a"]'}
      end
    end
  end
end
