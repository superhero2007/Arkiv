class FundSource < ActiveRecord::Base
  include Currencible

  attr_accessor :name

  paranoid

  belongs_to :member

  validates_presence_of :uid, :extra, :member, :routing_number

  def label
    if currency_obj.try :coin?
      "#{uid} (#{extra})"
    else
      ["#{extra}", "****#{uid[-15..-1]}"].join('#')
    end
  end

  def as_json(options = {})
    super(options).merge({label: label})
  end
end
