class Program < ApplicationRecord
    has_many :users
    has_many :tips
    has_many :experinces
end