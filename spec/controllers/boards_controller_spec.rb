require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  include Devise::TestHelpers

  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }
  let(:json) { JSON.parse(response.body) }

  describe 'GET index' do

    before(:each) do
      sign_in user
      board
    end

    it 'returns status of OK' do
      get :index, format: :json
      expect( response.status ).to eq 200
    end

    it 'gets all of the boards' do
      get :index, format: :json
      expect(json.first['id']).to eq board.id
    end

    it 'does not return boards which a user is not a member of' do
      other_user = create(:user)
      other_board = create(:board, user: other_user)
      get :index, format: :json

      expect(json.length).to eq 1
    end

    it 'returns boards which the user did not create, but is a member of' do
      other_user = create(:user)
      other_board = create(:board, name: 'other board', user: other_user)
      other_board.members << user
      get :index, format: :json

      expect(json.length).to eq 2
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

  describe 'GET #show' do
    before do
      sign_in user
    end

    it 'returns the board' do
      get :show, id: board.id
      expect(json['name']).to eq board.name
    end
  end

  describe 'PUT #update' do

    let(:board_updated) { attributes_for(:board, user_id: user.id, name: 'hello') }
    let(:invalid_board_update) { attributes_for(:board, user_id: user.id, name: '') }

    before do
      sign_in user
    end

    it 'updates the board with valid params' do
      put :update, id: board.id, board: board_updated
      expect(json['name']).to_not eq board.name
    end

    it 'does not update the board with invalid params' do
      put :update, id: board.id, board: invalid_board_update
      expect(response.status).to eq 422
    end
  end

  describe 'DELETE #destroy' do

    before do
      board
      sign_in user
    end

    it 'removes a board' do
      expect{delete :destroy, id: board.id}.to change { Board.count }.by -1
    end
  end
end
