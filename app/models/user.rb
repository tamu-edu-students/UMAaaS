class User < ApplicationRecord
    attr_accessor :id, :name, :email, :img, :isAdmin

    def marshal_dump
        [@id, @name, @email, @isAdmin, @img]
    end
    def marshal_load array
        @id, @name, @email, @isAdmin, @img = array
    end
end
