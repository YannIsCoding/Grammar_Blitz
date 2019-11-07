class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @exercices = Exercice.all
  end

  def show
    @exercice = Exercice.find(params[:id])
    @sentence = ''
    structure = @exercice.structure.structure_elements
    person = SentenceBuilder.person
    structure.each do |el|
      p 'this is the inside p:'
      p el.element.value
      @sentence = @sentence + " #{el.element.value}"
    end
    @sentence


  end
end
