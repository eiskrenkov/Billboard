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
    request_performer.perform
    Devices::Synchronizer.new(resource, response).synchronize

    if request_performer.success?
      flash[:notice] = 'Job was queued'
    else
      flash[:alert] = request_performer.error
    end

    redirect_back fallback_location: root_path
  end

  private

  def request_performer
    @request_performer ||= Devices::ScheduleRequestPerformer.new(resource)
  end

  def device_params
    params.require(:device).permit(:name, :internal_name, :bytes_capacity)
  end
end
