require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  # before_action :set_exercice, only: [:show, :setup]
  # before_action :set_sentence, only: [:show, :setup]

  def index
    @exercices = Exercice.all.order(:created_at)
  end

  def setup
    @exercice = Exercice.find(params[:id])
    last_sentence = Sentence.where(user: current_user, exercice: @exercice).last
    @sentence = Sentence.create(user: current_user, exercice: @exercice)
    @sentence.update(word_indexes: last_sentence.word_indexes) if last_sentence
    # @sentence.update(word_indexes: Sentence.where(user: current_user, exercice: @exercice).last)
  end

  private

  def setup_params
    ['subject', 'verb', '_article', 'noun', 'noun2'].map { |el| params[el] if params.key?(el) }.compact
  end
end
