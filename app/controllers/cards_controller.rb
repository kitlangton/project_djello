class CardsController < ApplicationController
  before_action :set_list

  def index
    @cards = @list.cards
    render json: @cards
  end

  def create
    @card = @list.cards.new(card_params)
    if @card.save
      render json: @card
    else
      render json: @card
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def card_params
    params.require(:card).permit(:body)
  end
end
