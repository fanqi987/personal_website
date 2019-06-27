class MaterialsController < ApplicationController

  before_action :init_post

  TYPE = {
      CODE: "编程",
      ENG: "英语",
      READ: "读书",
      MUSIC: "音乐",
      PLANT: "植物",
      PAINT: "画画",
      FIT: "健身",
      GAME: "游戏"
  }

  MATERIAL_PAGE_NUM = 12

  def index
    #先确定类别,再确定搜索条件,再确定页码
    p params
    if (params[:type] && !params[:type].empty?)
      @materials = @user.materials.where("'materials'.'material_type' = ? ", params[:type])
    else
      @materials = @user.materials
    end
    p @materials
    if (params[:search])
      t_start_time = params[:search][:start_time]
      t_end_time = params[:search][:end_time]
      t_word = params[:search][:word]
      @materials = get_search_result @materials,
                                     t_start_time,
                                     t_end_time,
                                     t_word,
                                     "materials",
                                     params[:type]


    end
    @meterials_count = @materials.count
    @materials = @materials.paginate(page: params[:page], per_page: MATERIAL_PAGE_NUM)
  end

  def create
    @material = @user.materials.build(material_params)
    if (@material.save)
      flash[:success] = "创建素材成功!"
    else
      flash[:danger] = "素材创建失败!" + getObjectErrors(@material)
    end
    redirect_to action: :index
  end

  def destroy
    @material = Material.find_by(id: params[:id])
    if @material.destroy
      flash[:success] = "删除素材成功!"
    else
      flash[:danger] = "删除素材失败!" + getObjectErrors(@material)
    end
    redirect_to materials_path + "#material_choose_section"
  end


  private

  def init_post
    @user = User.find_by(id: ADMIN_ID)
    @post = {post_modal_id: 'material_post_modal', modal_title: '发布新素材', material: true}
    @search_section = {search_section_name: " 搜索素材", material: true}
    @search_modal = {search_modal_id: "material_search_modal", modal_title: '搜索素材'}
    @material = @user.materials.build
  end

  def material_params
    params.require(:material).permit(:title, :content, :href, :material_type)
  end
end
