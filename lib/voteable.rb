# Using Concerns
module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end

# Using nomal metaprogramming
# module Voteable
#   module ClassMethods
#     def my_class_method
#       has_many :votes, as: :voteable    
#     end
#   end
  
#   module InstanceMethods
#     def total_votes
#       self.up_votes - self.down_votes
#     end

#     def up_votes
#       self.votes.where(vote: true).size
#     end

#     def down_votes
#       self.votes.where(vote: false).size
#     end
#   end
  
#   def self.included(base)
#     base.extend         ClassMethods
#     base.send :include, InstanceMethods
#     base.class_eval do
#       my_class_method
#     end
#   end
# end