class Board < ActiveRecord::Base

  searchable do
    text :title, :description
    integer :user_id
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :pins

  def self.search_board(search_key)
    @search = self.search do
      fulltext "#{search_key}"
    end
    @search.results
  end
end
