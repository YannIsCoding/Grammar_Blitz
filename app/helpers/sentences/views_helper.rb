module Sentences
  module ViewsHelper
    def hide_answer(sentence, positions)
      # transform in array
      splited_sentence = sentence.split(' ')

      # each word marked is replaced
      positions.each do |position|
        splited_sentence[position.to_i] = '_____'
      end

      # joined back
      splited_sentence.join(' ')
    end

    def split_sentence(sentence, positions)
      # transform in array
      sentence_array = sentence.split(' ')
      positions.each { |position| sentence_array[position] = nil }
      sentence_array
    end

    def show_streak?(streak)
      (streak % 5).zero? && !streak.zero?
    end

    def streak_congratulation
      ['Du bist der hammer!', 'Du bist MEGA geil!', 'bärenstark!'].sample
    end

    def print_response(responses)
      message = ''
      responses.each do |response|
        message << " #{response} -"
      end
      message[-2..-1] = ''
      message
    end
  end
end
