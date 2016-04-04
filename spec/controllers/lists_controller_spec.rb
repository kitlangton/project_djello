require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  include Devise::TestHelpers

  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }
  let(:list) { create(:list, board: board) }
  let(:json) { JSON.parse(response.body) }

  describe 'GET index' do
    before(:each) do
      sign_in user
      list
    end

    it 'returns a status of OK' do
      get :index, format: :json, board_id: board.id
      expect(response.status).to eq 200
    end

    it 'returns the boards lists' do
      get :index, format: :json, board_id: board.id
      expect(json[0]['name']).to eq list.name
    end
  end

  describe 'POST #create' do
    let(:valid_list_attributes) { attributes_for(:list, board_id: board.id) }
    let(:invalid_list_attributes) { attributes_for(:list, name: '') }

    before do
      sign_in user
    end

    it 'creates a board with valid attributes' do
      expect { post :create, board_id: board.id, list: valid_list_attributes }.to change { List.count }.by 1
      expect(response.status).to eq 200
    end

    it 'returns errors for an invalid board' do
      post :create, board_id: board.id, list: invalid_list_attributes
      expect(response.status).to eq 422
    end
  end
end
