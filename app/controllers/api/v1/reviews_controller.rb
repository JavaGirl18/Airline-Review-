# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        review = Review.new(title: params[:title], description: params[:description],
                            score: params[:score], airline_id: params[:airline_id])

        if review.save(title: params[:title], description: params[:description],
                       score: params[:score], airline_id: params[:airline_id])
          render json: ReviewSerializer.new(review).serialized_json
        else
          render json: { error: review.error.messages }, status: 422
        end
      end

      def destroy
        review = Review.find(params[:id])
        if review.destroy
          head :no_content
        else
          render json: { error: review.errors.messages }, status: 422
        end
      end

      private

      def review_params
        params.require(:review).permit(:title, :description, :score, :airline_id)
      end
    end
  end
end
