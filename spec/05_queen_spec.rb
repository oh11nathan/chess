
require_relative '../lib/queen'

describe Queen do

    describe '#initialize' do
        # only assigning instance variables, see methods that assign variables
    end

    describe '#determine_side' do
        context 'when initialized with white' do
            subject(:white_queen) { Queen.new("white", "D1") }
            it 'returns the white queen icon' do
                expect(white_queen.icon).to eq("\u2655".encode)
            end
        end

        context 'when initialized with black' do
            subject(:black_queen) { Queen.new("black", "D8") }
            it 'returns the black queen icon' do
                expect(black_queen.icon).to eq("\u265B".encode)
            end
        end
    end

    describe '#queen_valid_moves' do
        subject(:queen) { Queen.new("white", "D1") }
        context 'upon initialization' do
            it 'returns an array' do
                expect(queen.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(queen.valid_moves).to_not include(nil)
            end
        end

        context 'upon moving positions' do
            before do 
                queen.changed_position("D4")
            end
            it 'returns an array' do
                expect(queen.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(queen.valid_moves).to_not include(nil)
            end
            it 'updates @valid_moves with the correct values' do
                new_moves = Queen.new("white", "D4").valid_moves
                expect(queen.valid_moves).to eq(new_moves)
            end
        end

    end

end