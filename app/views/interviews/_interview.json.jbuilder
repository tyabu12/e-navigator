json.extract! interview, :id, :start_time, :status, :user_id, :created_at, :updated_at
json.url interview_url(interview, format: :json)
