class SettingsController < ApplicationController
  defaults resource_class: Settings, singleton: true

  navigation_section :settings

  def update
    update! { settings_path }
  end

  def resource
    Settings.instance
  end

  private

  def permitted_params
    params.permit!
  end
end
