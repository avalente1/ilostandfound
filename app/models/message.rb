class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :finder, class_name: 'User'
end
