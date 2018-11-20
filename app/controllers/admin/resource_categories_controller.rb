# -*- coding: utf-8 -*-
class Admin::ResourceCategoriesController < ApplicationController
  layout "admin"

  before_action :set_resource_category, only: [:show, :edit, :update, :destroy, :change_show_tab, :render_tab_content]
  before_action :set_navigation, only: [:new, :edit, :show, :destroy]
  before_action :class_authorize, only: [:index, :new, :create]

  def index
    session[:navigation] = []
  end

  def datatables
    authorize [:admin, ResourceCategory], :index?

    respond_to do |format|
      # 設定排序條件
      unless params[:order].blank?
        params[:order].each do |k,v|
          @order_columns ||= []
          @order_columns << "#{params[:columns][ v[:column] ][:data]} #{ v[:dir] }".gsub('_i18n', '')
        end
      end

      @page = (params[:start].to_i/params[:length].to_i) + 1 # 要顯示資料的頁數
      @filters = DatatablesService.new({class_name: "ResourceCategory"}).handle_filters(params)
      @keyword = params[:search][:value] unless params[:search].blank?
      @filters["id_cont".to_sym] = @keyword if @keyword
      class_scope = Admin::ResourceCategoryPolicy::Scope.new(current_user, ResourceCategory).resolve
      active_record_query = class_scope
      @q = active_record_query.ransack(@filters)
      @q.sorts = @order_columns.empty? ? ["updated_at desc"] : @order_columns
      @resource_categories = @q.result.page(@page).per(params[:length])
      @filtered_count = @q.result.count
      @total_count = active_record_query.count

      format.json {
        render json: {
          recordsTotal: @total_count, # 資料總筆數
          recordsFiltered: @filtered_count, # 過濾後資料筆數
          data: to_datatables(@resource_categories) # 整理查詢結果
        }
      }
    end
  end

  def new
    @resource_category ||= ResourceCategory.new
  end

  def create
    @resource_category = ResourceCategory.new(resource_category_params)
    respond_to do |format|
      if @resource_category.save
        # 更新已上傳、但未設定 attachable_id 的檔案資料
        Attachment.update_attachable_ids(params[:attachments], @resource_category.id)

        format.html {
          flash[:notice] = I18n.t('helpers.form.create_success', model: ResourceCategory.model_name.human)
          back
        }
        format.js {}
      else
        format.html {
          render :new
        }
        format.js {}
      end
    end
  end

  def edit

  end

  def show
    @tabs = tabs
  end

  def update
    respond_to do |format|
      if @resource_category.update(resource_category_params)
        format.html {
          flash[:notice] = I18n.t('helpers.form.update_success', model: ResourceCategory.model_name.human)
          back
        }
        format.js {}
      else
        format.html {
          render :edit
        }
        format.js {}
      end
    end
  end

  def destroy
    @resource_category.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = I18n.t('helpers.form.destroy_success', model: ResourceCategory.model_name.human)
        back
      }
      format.js {}
    end
  end

  # 更新列表的單筆 row 資料
  def update_row
    params[:data].each do |id, column_values|
      respond_to do |format|
        format.json {
          resource_category = ResourceCategory.find_by(id: id)

          authorize [:admin, resource_category]

          resource_category_params = resource_category_row_params(column_values)
          if resource_category&.update(resource_category_params)
            resource_categories = ResourceCategory.where(id: id)
            render json: {data: to_datatables(resource_categories)}
          end
        }
      end
    end
  end

  # 設定連結所屬明細頁籤
  def tabs
    tabs_array = []
    tabs_array << {name: 'resource_categories'}
    tabs_array
  end

  # 變換頁籤顯示內容
  def change_show_tab
    @current_tab = tabs.select{ |tab| tab[:name] == params[:tab] }.first
    @current_tab = tabs.first if @current_tab.nil?
    row_count_vars_of_tab(@current_tab[:name])

    respond_to do |format|
      format.js {}
    end
  end

  def render_tab_content
    master_show_tab = params[:master_show_tab]
    master_show_tab = tabs.first[:name] if tabs.select{ |tab| tab[:name] == master_show_tab }.count == 0
    row_count_vars_of_tab(master_show_tab)

    render partial: "admin/resource_categories/tabs/#{master_show_tab}_tab", locals: { resource_category: @resource_category, master_show_tab: master_show_tab }
  end

  def back
    _navigation = session[:navigation].pop
    redirect_to admin_resource_categories_path if _navigation.nil?
    redirect_to "#{_navigation[:master_show_url] || _navigation['master_show_url']}?master_show_tab=#{_navigation[:master_show_tab] || _navigation['master_show_tab']}&ignore_set_navigation=true" unless _navigation.nil?
  end

  private

  def set_resource_category
    @resource_category = ResourceCategory.find(params[:id])
    authorize [:admin, @resource_category]
  end

  def resource_category_params
    params.require(:resource_category).permit(:name)
  end

  def resource_category_row_params(column_values)
    column_values.permit(:name)
  end

  # 處理呈現在datatable的資料結構
  def to_datatables(resource_categories)
    resource_categories.map do |resource_category|
      {
        DT_RowId: "#{resource_category.id}",
        id: resource_category.id,
        name: resource_category.name,
        created_at: resource_category.created_at&.strftime('%F %T'),
        updated_at: resource_category.updated_at&.strftime('%F %T'),
      }
    end
  end

  def set_navigation
    return if params[:ignore_set_navigation]
    referrer = request.referrer
    return if referrer.blank?
    session[:navigation] ||= []
    _navigation = {}
    _navigation[:master_show_url] = referrer[0, referrer.index('?') || referrer.length]
    _navigation[:master_show_tab] = params[:master_show_tab]
    session[:navigation] << _navigation
  end

  # 計算列表頁面上的資料筆數統計值
  def row_count_vars_of_tab(tab_name)
    case tab_name
    when 'resource_category'
    end
  end

  def class_authorize
    authorize [:admin, ResourceCategory]
  end
end
