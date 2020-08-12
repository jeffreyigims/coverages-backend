class ApplicationRecord < ActiveRecord::Base
  include PgSearch::Model
  self.abstract_class = true

  def as_json(options = {})
    super(options.merge({ :methods => :type }))
  end

  def type
    r = self.class.table_name
    r
  end
end
