module Mousetrap
  class Invoice < Resource
    attr_accessor \
      :id,
      :number,
      :billing_date,
      :created_at,
      :amount

    def initialize(hash = {})
      super(self.class.attributes_from_api(hash))
    end

    protected

    def self.plural_resource_name
      'invoices'
    end

    def self.singular_resource_name
      'invoice'
    end

    def attributes
      {
        :id           => id,
        :number       => number,
        :billing_date => billing_date,
        :created_at   => created_at,
        :amount       => amount
      }
    end

    def self.attributes_from_api(attributes)
      {
        :id           => attributes['id'],
        :number       => attributes['number'],
        :billing_date => attributes['billingDatetime'],
        :created_at   => attributes['createdDatetime'],
        :amount       => attributes['charges']['charge'].class == Array ? attributes['charges']['charge'].inject(0.0) {|sum, c| sum.to_f + (c['eachAmount'].to_f * c['quantity'].to_i)} : attributes['charges']['charge']['eachAmount'].to_f  * attributes['charges']['charge']['quantity'].to_i
      }
    end
  end
end