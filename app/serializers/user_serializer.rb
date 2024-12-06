class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_name, :email, :created_at, :updated_at

  has_many :products
end