class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board

  def index
    @lists = @board.lists
    render json: @lists
  end

  def create
    @list = @board.lists.build(list_params)
    if @list.save
      render json: @list
    else
      render json: { errors: @list.errors.full_messages }, status: 422
    end
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
