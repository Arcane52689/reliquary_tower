class BanSerializer < ActiveModel::Serializer
  attributes :id, :card_name, :format, :restricted
end
