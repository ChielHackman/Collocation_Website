class Locataire < ApplicationRecord
    validates :name, presence:true
    validates :surname, presence:true
    validates :contact, presence:true
    validates :place, presence:true
    validates :sexe, presence:true
    validates :age, presence:true
    validates :other, presence:true
    validates :loyer, presence:true

    # After a form for a new locataire is submitted call the compare_forms method
    after_create :compare_forms

    def compare_forms
      # Put all owners in a variable so you can compare the filled in form with each of the owners
      owners = Owner.all

      # For each owner check if the age and sexe is equal to the age and sexe from the just created locataire and if so, create a new FromMatcher with the corresponding id's
      # FromMatcher should be FormMatcher and inside the FromMatcher table you want to change locataires_id to locataire_id because it represents one single locataire
      # Will prevent you from making mistakes in the future :-)
      owners.each do |owner|
        if owner.age == age && owner.sexe == sexe
          FromMatcher.create(locataire_id: id, owner_id: owner.id)
        end
      end
    end

end
