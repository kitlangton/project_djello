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

  def update
    @list = List.find(params[:id])
    new_params = list_params
    new_position = new_params.delete(:position)

    if @list.update(new_params)
      @list.insert_at(new_position)
      render json: @list
    else
      render json: @list
    end
  end

  def destroy
    List.find(params[:id]).destroy
    render json: true
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def list_params
    params.require(:list).permit(:name, :position)
  end
end
