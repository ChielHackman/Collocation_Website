class Owner < ApplicationRecord
    validates :name, presence:true
    validates :surname, presence:true
    validates :contact, presence:true
    validates :place, presence:true
    validates :owner_type, presence:true
    validates :number, presence:true
    validates :age, presence:true
    validates :other, presence:true
    validates :rent, presence:true
    validates :lead, presence:true
    validates :bail, presence:true
    validates :comments, presence:true

    # After a form for a new owner is submitted call the compare_forms method
    after_create :compare_forms

    def compare_forms
      # Put all locataires in a variable so you can compare the filled in form with each of the locataires
      locataires = Locataire.all

      # For each locataire check if the age and sexe is equal to the age and sexe from the just created owner and if so, create a new FromMatcher with the corresponding id's
      # FromMatcher should be FormMatcher and inside the FromMatcher table you want to change locataires_id to locataire_id because it represents one single locataire
      # Will prevent you from making mistakes in the future :-)
      locataires.each do |locataire|
        if locataire.age == age && locataire.sexe == sexe
          FromMatcher.create(owner_id: id, locataires_id: locataire.id)
        end
      end
    end

end
