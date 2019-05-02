Rails.logger.info "Loading #{__FILE__}"
ThinkingSphinx::Index.define :post, with: :real_time do
  indexes title, type: :string
  indexes body, type: :string
end
