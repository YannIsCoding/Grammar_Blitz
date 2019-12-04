# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# User.delete_all
# Verb.delete_all
# Noun.delete_all
# Preposition.delete_all
# StructureElement.delete_all
# Element.delete_all
# Exercice.delete_all
# Structure.delete_all

# url = "https://www.scienceabc.com/wp-content/uploads/2015/12/alan-turing.jpg"
# u = User.create!(
#   email: 'me@me.me',
#   password: '123456',
#   username: 'Alan'
#   )
# u.remote_photo_url = url
# u.save








# prep = [
#   # %w[durch accusative through] << %w[sehen gehen], # verb: mouvement noun:place
#   ['für', 'accusative', 'for', ['sein'], ['idea']], # verb: be noun: people
#   ['gegen', 'accusative', 'against', ['sein'], ['idea']] # verb: be noun: vehicule, food
#   # %w[ohne accusative without],<< %w[sein] #verb: be buy noun: people vehicule food
#   # %w[um accusative around] #verb: buy noun: time
# ]

# prep.each do |array|
#   Preposition.create!(
#     value: array[0],
#     g_case: array[1],
#     english: array[2],
#     verbs: array[3],
#     kind_nouns: array[4]
#     )
# end


# %w[subject verb do io preposition].each do |el|
#   Element.create!(value: el)
# end

# %w[s_v_prep_do s_v_do v_s_do s_v_do_dative s_v_io_do conjug].each do |structure|
#   Structure.create!(name: structure)
# end
# %w[conjug].each do |structure|
#   Structure.create!(name: structure)
# end
# structure_elements = [
#   %w[1 subject s_v_prep_do],
#   %w[2 verb s_v_prep_do],
#   %w[3 preposition s_v_prep_do],
#   %w[4 do s_v_prep_do],
#   %w[1 subject s_v_do],
#   %w[2 verb s_v_do],
#   %w[3 do s_v_do]
# ]

# structure_elements.each do |array|
#   StructureElement.create!(
#     position: array[0].to_i,
#     element_id: Element.find_by(value: array[1]).id,
#     structure_id: Structure.find_by(name: array[2]).id
#     )
# end

Exercice.find_or_create_by!(
  name: 'Sentence with direct object and accusative',
  description: 'simple sentence structure with accusative and direct object',
  structure: Structure.find_by(name: 's_v_do')
  )
# Exercice.find_or_create_by!(
#   name: 'Sentence with direct object and accusative with preposition',
#   description: 'simple sentence structure with accusative and preposition',
#   structure: Structure.find_by(name: 's_v_prep_do')
#   )
Exercice.find_or_create_by!(
  name: ' Questions with direct object and accusative',
  description: 'Questions with accusative and preposition',
  structure: Structure.find_by(name: 'v_s_do')
  )
Exercice.find_or_create_by!(
  name: ' Sentence with direct object and dative',
  description: 'Sentence with dative and preposition',
  structure: Structure.find_by(name: 's_v_do_dative')
  )
Exercice.find_or_create_by!(
  name: ' Sentence with direct and indirect object ',
  description: 'Sentence with direct and indirect object',
  structure: Structure.find_by(name: 's_v_io_do')
  )
Exercice.find_or_create_by!(
  name: 'Conjugation practice',
  description: 'Practice conjugaison on all sort of verbs',
  structure: Structure.find_by(name: 'conjug')
  )

puts 'Root seeds file DONE!'
