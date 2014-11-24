module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    scope :by_query, -> query { search(query).records }
    index_name "admin-with-postgre"
    document_type "#{self.to_s.pluralize.underscore.dasherize}"

    def as_indexed_json(options={})
      as_json
    end
  end

end
