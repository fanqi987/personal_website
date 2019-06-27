module MaterialsHelper

  def getType(value)
    MaterialsController::TYPE.key(value).to_s
  end
end
