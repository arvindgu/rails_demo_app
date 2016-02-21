json.array!(@accounts) do |account|
  json.extract! account, :id, :user_id, :amount, :address, :phone, :status
  json.url account_url(account, format: :json)
end
