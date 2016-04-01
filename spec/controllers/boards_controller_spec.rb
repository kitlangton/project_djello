require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  include Devise::TestHelpers

  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }
  let(:json) { JSON.parse(response.body) }

  describe 'GET index' do

    before do
      sign_in user
      board
      get :index, format: :json
    end

    it 'returns status of OK' do
      expect( response.status ).to eq 200
    end

    it 'gets all of the boards' do
      expect(json.first['id']).to eq board.id
    end
  end

  describe 'POST #create' do

    let(:valid_board_attributes) { attributes_for(:board, user_id: user.id) }
    let(:invalid_board_attributes) { attributes_for(:board, name: '') }

    before do
      sign_in user
    end

    it 'creates a board with valid attributes' do
      expect { post :create, board: valid_board_attributes }.to change { Board.count }.by 1
      expect(response.status).to eq 200
    end

    it 'returns errors for an invalid board' do
      post :create , board: invalid_board_attributes
      expect(response.status).to eq 422
    end
  end
end
