class TaskTag < ApplicationRecord
  belongs_to :tag
  belongs_to :task, optional: true
  belongs_to :template_task, optional: true
end
