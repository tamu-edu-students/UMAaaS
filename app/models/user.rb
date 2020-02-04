class User < ApplicationRecord
    belongs_to :program, optional: true
    attr_accessor :img
end
