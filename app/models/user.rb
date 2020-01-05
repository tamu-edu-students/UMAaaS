class User < ApplicationRecord
    attr_accessor :id, :name, :email, :img

    def marshal_dump
        [@id, @name, @email, @img]
    end
    def marshal_load array
        @id, @name, @email, @img = array
    end
end
