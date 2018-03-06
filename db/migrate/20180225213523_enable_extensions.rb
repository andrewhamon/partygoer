class EnableExtensions < ActiveRecord::Migration[5.1]
  def change
    enable_extension :cube
    enable_extension :earthdistance
  end
end
