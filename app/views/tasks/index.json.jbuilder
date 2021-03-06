json.array!(@tasks) do |task|
  json.extract! task, :id, :description, :due_at, :priority, :user_id
  json.url task_url(task, format: :json)
end
