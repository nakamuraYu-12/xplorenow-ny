class ChangeDataIntroductionToEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :introduction, :text
  end
end
