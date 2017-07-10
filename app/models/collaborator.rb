class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  class << self
    def update_collaborators
      return Collaborator.none if collaborator_string.blank?
        collaborator_string.split(",").map do |collaborator|
            Collaborator.find_or_create_by(email: collaborator.strip)
        end
    end
  end
end
