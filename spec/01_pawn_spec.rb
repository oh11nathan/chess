
require_relative '../lib/pawn'

describe Pawn do

    subject(:white_pawn) { Pawn.new("white", "A1") }

    describe '#initialize' do
        
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
            xit 'returns an array' do

            end
            xit 'returns an array which does not contain nil' do
            
            end
            xit 'updates @valid_moves with the correct values' do 
                
            end
        end

    end

    describe '#changed_position?' do
        
    end

    describe '#completed_one_move?' do
        
    end

end