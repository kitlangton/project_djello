class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = current_user.joined_boards
    respond_to do |format|
      format.json { render json: @boards }
    end
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      render json: @board
    else
      render json: { errors: @board.errors.full_messages }, status: 422
    end
  end

  def show
    @board = Board.find(params[:id])
    render json: @board
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      render json: @board
    else
      render json: { errors: @board.errors.full_messages }, status: 422
    end
  end

  def destroy
    @board = Board.find(params[:id])
    if @board.destroy
      render json: @board
    else
      render json: { errors: @board.errors.full_messages }, status: 422
    end
  end

  private

  def board_params
    params.require(:board).permit(:name, :user_id)
  end
end
