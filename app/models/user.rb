class User < ApplicationRecord
    belongs_to :program, optional: true
    has_many :tips
    attr_accessor :img
    
end
