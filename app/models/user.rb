class User < ActiveRecord::Base
	require 'roo'	

  validates_presence_of :name, :age, :favorite_food

  before_create :validate



  
def self.import(file)
  row_cnt=0
  @user_errors={}
  CSV.foreach(file.path, headers: true) do |row|
    user_hash = row.to_hash 
    @user = User.new(user_hash)
    row_cnt +=1      
     if @user.valid?
        @user.save
      else
        @user_errors[row_cnt] = @user.errors.full_messages
    end 
  end 
  return @user_errors unless @user_errors.empty?
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
   when '.csv' then Roo::Csv.new(file.path, nil)
   when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
   when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
   else raise "Unknown file type: #{file.original_filename}"
  end
end



protected
  def validate
    errors.add(:age, "Age can't be balnk..") if age.nil? 
  end
end
