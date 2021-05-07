
require_relative '../lib/rook'

describe Rook do

    describe '#initialize' do
        # only assigning instance variables, see methods that assign variables
    end

    describe '#determine_side' do
        context 'when initialized with white' do
            subject(:white_rook) { Rook.new("white", "A1") }
            it 'returns the white rook icon' do
                expect(white_rook.icon).to eq("\u2656".encode)
            end
        end

        context 'when initialized with black' do
            subject(:black_rook) { Rook.new("black", "A8") }
            it 'returns the black rook icon' do
                expect(black_rook.icon).to eq("\u265C".encode)
            end
        end
    end

    describe '#rook_valid_moves' do
        subject(:rook) { Rook.new("white", "A1") }
        context 'upon initialization' do
            it 'returns an array' do
                expect(rook.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(rook.valid_moves).to_not include(nil)
            end
        end

        context 'upon moving positions' do
            before do 
                rook.changed_position("A2")
            end
            it 'returns an array' do
                expect(rook.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(rook.valid_moves).to_not include(nil)
            end
            it 'updates @valid_moves with the correct values' do
                new_moves = Rook.new("white", "A2").valid_moves
                expect(rook.valid_moves).to eq(new_moves)
            end
        end

    end

    describe '#changed_position?' do
        # see tests for rook_valid_moves
    end

end