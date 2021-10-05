module TasksHelper
  def button_text
    if action_name.in?(%w[new create])
      '新規登録'
    elsif action_name.in?(%w[edit update])
      '変更内容を保存'
    end
  end
end
