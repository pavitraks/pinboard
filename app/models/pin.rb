class Pin < ActiveRecord::Base

  searchable do
    text :name, :image
    integer :board_id
    end

  paginates_per 15

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :board

  mount_uploader :image, ImageUploader

  def self.search_pin(search_key)
    @search = self.search do
      fulltext "#{search_key}"
    end
    @search.results
  end

  def repin_post(board_id)
    puts board_id
    pin = Pin.new
    pin.name = self.name
    pin.board_id = board_id
    pin.image = self.image
    pin.save
    return pin
  end

  def self.send_newsletter
    @user = User.all
    @user.each do |u|
      @pins = self.all(:limit => 5)
      puts Newsletter.letter(u, @pins).deliver
    end
  end
end
