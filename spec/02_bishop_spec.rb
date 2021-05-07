
require_relative '../lib/bishop'

describe Bishop do

    describe '#initialize' do
        # only assigning instance variables, see methods that assign variables
    end

    describe '#determine_side' do
        context 'when initialized with white' do
            subject(:white_bishop) { Bishop.new("white", "C1") }
            it 'returns the white bishop icon' do
                expect(white_bishop.icon).to eq("\u2657".encode)
            end
        end

        context 'when initialized with black' do
            subject(:black_bishop) { Bishop.new("black", "C8") }
            it 'returns the black bishop icon' do
                expect(black_bishop.icon).to eq("\u265D".encode)
            end
        end
    end

    describe '#bishop_valid_moves' do
        subject(:bishop) { Bishop.new("white", "C1") }
        context 'upon initialization' do
            it 'returns an array' do
                expect(bishop.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(bishop.valid_moves).to_not include(nil)
            end
        end

        context 'upon moving positions' do
            before do 
                bishop.changed_position("D2")
            end
            it 'returns an array' do
                expect(bishop.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(bishop.valid_moves).to_not include(nil)
            end
            it 'updates @valid_moves with the correct values' do
                new_moves = Bishop.new("white", "D2").valid_moves
                expect(bishop.valid_moves).to eq(new_moves)
            end
        end

    end

    describe '#changed_position?' do
        # see tests for bishop_valid_moves
    end
        
end