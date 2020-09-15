module Edicts
  module ViewsHelper
    def highlight_hidden_word(sentence, positions)
      # highlight which words are hidden from user
      sentence_array = sentence.split(' ')
      html = ""
      sentence_array.each_with_index do |word, index|
        if positions.include?(index.to_s)
          html << "<span class='failure'>#{word} </span>"
        else
          html << "<span>#{word} </span>"
        end
      end
      html.html_safe
    end
  end
end
