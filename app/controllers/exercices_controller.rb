require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @exercices = Exercice.all.order(:created_at)
  end

  def setup
    @exercice = Exercice.find(params[:id])
    last_sentence = Sentence.where(user: current_user, exercice: @exercice).last
    @sentence = Sentence.create(user: current_user, exercice: @exercice)
    @sentence.update(word_indexes: last_sentence.word_indexes) if last_sentence
  end

  private

  def setup_params
    ['subject', 'verb', '_article', 'noun', 'noun2'].map { |el| params[el] if params.key?(el) }.compact
  end
end
