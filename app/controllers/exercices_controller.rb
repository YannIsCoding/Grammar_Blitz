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
    @sentence = Sentence.find_or_create_by(user: current_user, exercice: @exercice)
    @sentence.update(word_indexes: @sentence.exercice.hide_index, session_counter: 0)
    @sentence.update(word_indexes: (@sentence.word_indexes << setup_params).flatten)
  end

  private

  def setup_params
    ['subject', 'verb', '_article', 'noun', 'noun2'].map { |el| params[el] if params.key?(el) }.compact
  end
end
