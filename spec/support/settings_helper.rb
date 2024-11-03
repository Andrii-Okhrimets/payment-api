require 'rails_helper'

module SettingsHelper
  def reload_settings(env = 'test')
    Config.load_and_set_settings(Config.setting_files(::Rails.root.join('config'), env))
  end
end

RSpec.configure do |c|
  c.include SettingsHelper
end
