class DevicesController < ApplicationController
  defaults resource_class: Device

  navigation_section :devices

  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  def synchronize
    synchronizer = Devices::Synchronizer.new(resource)

    if synchronizer.synchronize
      flash[:notice] = 'Device schedule was synchronized successfully'
    else
      flash[:alert] = synchronizer.error
    end

    redirect_back fallback_location: root_path
  end

  private

  def device_params
    params.require(:device).permit(:name, :internal_name, :bytes_capacity)
  end
end
