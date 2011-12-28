#!/usr/bin/ruby
#
#  check-translations.rb DIR LANG
#

require 'yaml'

dir  = ARGV[0]
lang = ARGV[1]

i18n_en   = YAML.load_file("#{dir}/en.yml")
i18n_lang = YAML.load_file("#{dir}/#{lang}.yml")

def walk(path, en, other)
    en.keys.sort.each do |key|
        name = path.sub(/^\./, '') + '.' + key
        if en[key].class == Hash
            if other.nil?
                puts "MISSING: #{name} [en=#{en[key]}]"
            else
                walk(path + '.' + key, en[key], other[key])
            end
        else
#            puts "#{name} [#{en[key]}] [#{other[key]}]"
            if other.nil?|| ! other[key]
                puts "MISSING: #{name} [en=#{en[key]}]"
            end 
        end
    end
end

walk('', i18n_en, i18n_lang)
