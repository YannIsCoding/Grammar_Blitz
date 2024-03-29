module Sentences
  module ViewsHelper
    # def hide_answer(sentence, positions)
    #   # transform in array
    #   splited_sentence = sentence.split(' ')

    #   # each word marked is replaced
    #   positions.each do |position|
    #     splited_sentence[position.to_i] = '_____'
    #   end

    #   # joined back
    #   splited_sentence.join(' ')
    # end

    def split_sentence(sentence, positions)
      # Hide the words the user is tested for
      sentence_array = sentence_to_array(sentence)
      positions.each { |position| sentence_array[position.to_i] = nil }
      sentence_array
    end

    def sentence_to_array(sentence)
      sentence.split(' ')
    end

    def show_streak?(streak)
      # Show congrats every 5 corrects answers
      (streak % 5).zero? && !streak.zero?
    end

    def streak_congratulation
      ['Du bist der Hammer!', 'Du bist MEGA geil!', 'bärenstark!'].sample
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
