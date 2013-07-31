# encoding: utf-8

require 'active_model/validations'
require 'public_suffix'

module ActiveModel
  module Validations
    class DomainNameValidator < ActiveModel::EachValidator
      IDN = 'ßàáâãóôþüúðæåïçèõöÿýòäœêëìíøùîûñé'

      def validate_each record, attribute, value
        url = record.url
        return record.errors.add(attribute, :blank) if url.blank?
        return record.errors.add(attribute, :invalid) unless PublicSuffix.valid?(url)

        domain = PublicSuffix.parse url
        return record.errors.add(attribute, :invalid) unless domain.domain =~ /^([0-9a-z#{IDN}\-]+\.)+([a-z#{IDN}]{2,})$/
        return record.errors.add(attribute, :invalid) if domain.trd && domain.trd !~ /^(?:\*|(?!www(?:\.|$))(?:[\*0-9a-z#{IDN}\-]+\.)*[0-9a-z#{IDN}\-]+)$/
        return record.errors.add(attribute, :exclusion) if domain.sld.in? %w[büllingen bütgenbach schönberg wallonië brüssel belgië woluwé-saint-lambert woluwé-saint-pierre anhée bièvre braine-le-château châtelet chièvres crisnée eghezée erezée ferrières flémalle fléron fontaine-levêque grâce-hollogne hastière hélecine héron labruyère lalouvière léglise liège merbes-le-château neufchâteau neupré péruwelz plombières pont-à-celles quévy quiévrain saint-léger vaux-sur-sûre visé dñs dnβ]
      end
    end

    module HelperMethods
      def validates_domain_name *attr_names
        validates_with DomainNameValidator, _merge_attributes(attr_names)
      end
    end
  end
end
