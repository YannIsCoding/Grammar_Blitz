class AddAtomizableToSentences < ActiveRecord::Migration[5.2]
  def change
    add_reference :sentences, :atomizable, polymorphic: true
  end
end
