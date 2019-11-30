class DevicesController < ApplicationController
  defaults resource_class: Device

  navigation_section :devices

  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  private

  def device_params
    params.require(:device).permit(:name, :internal_name)
  end
end
