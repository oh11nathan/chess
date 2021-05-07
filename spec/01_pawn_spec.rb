
require_relative '../lib/pawn'

describe Pawn do

    describe '#initialize' do
        # only assigning instance variables, see methods that assign variables
    end

    describe '#determine_side' do
        context 'when initialized with white' do
            subject(:white_pawn) { Pawn.new("white", "A2") }
            it 'returns the white pawn icon' do
                expect(white_pawn.icon).to eq("\u2659".encode)
            end
        end

        context 'when initialized with black' do
            subject(:black_pawn) { Pawn.new("black", "A7") }
            it 'returns the black pawn icon' do
                expect(black_pawn.icon).to eq("\u265F".encode)
            end
        end
    end

    describe '#pawn_valid_moves' do
        subject(:pawn) { Pawn.new("white", "A2") }
        context 'upon initialization' do
            it 'returns an array' do
                expect(pawn.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(pawn.valid_moves).to_not include(nil)
            end
        end

        context 'upon moving positions' do
            before do 
                pawn.changed_position("A3")
            end
            it 'returns an array' do
                expect(pawn.valid_moves).to be_a(Array)
            end
            it 'returns an array which does not contain nil' do
                expect(pawn.valid_moves).to_not include(nil)
            end
            it 'updates @valid_moves with the correct values' do 
                expect(pawn.valid_moves[0]).to eq("A4")
            end
        end

    end

    describe '#changed_position?' do
        # see tests for pawn_valid_moves and completed_one_move?
    end

    describe '#completed_one_move?' do
        subject(:new_pawn) { Pawn.new("white", "A2") }
        context 'upon initialization' do
            it 'returns false' do
                expect(new_pawn.instance_variable_get(:@completed_one_move)).to be(false)
            end
        end
        context 'upon completing a first move' do
            before do 
                new_pawn.changed_position("A3")
            end
            it 'returns true' do
                expect(new_pawn.instance_variable_get(:@completed_one_move)).to be(true)
            end
        end
    end

end