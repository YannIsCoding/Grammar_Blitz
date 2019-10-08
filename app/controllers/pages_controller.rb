ARTICLE = %w(der die das)
PP = %w(ich du er wir ihr Sie)
SEIN = %w(bin bist ist sind seid sind)
NOUN = %w(kate hund freund)

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :exercice]

  def home
  end

  def exercice
    number = rand(0..5)
    @part1 = PP[number] + ' ' + SEIN[number] + ' mit'
    @part2 = NOUN.sample
  end
end
