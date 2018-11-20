class Admin::VersionsController < ApplicationController
  layout "admin"

  before_action :set_version, only: [:show, :edit, :update, :destroy, :change_show_tab, :render_tab_content]
  before_action :set_navigation, only: [:new, :edit, :show, :destroy]
  before_action :class_authorize, only: [:index, :new, :create]

  def index
    session[:navigation] = []
  end

  def datatables
    authorize [:admin, Version], :index?
    

    respond_to do |format|
      # 設定排序條件
      unless params[:order].blank?
        params[:order].each do |k,v|
          @order_columns ||= []
          @order_columns << "#{params[:columns][ v[:column] ][:data]} #{ v[:dir] }".gsub('_i18n', '')
        end
      end

      @page = (params[:start].to_i/params[:length].to_i) + 1 # 要顯示資料的頁數

      @filters = DatatablesService.new({class_name: "Version"}).handle_filters(params)

      @keyword = params[:search][:value] unless params[:search].blank?
      @filters["id_cont".to_sym] = @keyword if @keyword

      class_scope = Admin::VersionPolicy::Scope.new(current_user, Version).resolve
      active_record_query = class_scope 
      @q = active_record_query.ransack(@filters)

      @q.sorts = @order_columns.empty? ? ["updated_at desc"] : @order_columns

      @versions = @q.result.page(@page).per(params[:length])
      @filtered_count = @q.result.count
      @total_count = active_record_query.count

      format.json {
        render json: {
          recordsTotal: @total_count, # 資料總筆數
          recordsFiltered: @filtered_count, # 過濾後資料筆數
          data: to_datatables(@versions) # 整理查詢結果
        }
      }
    end
  end

  def new
    @version ||= Version.new
  end

  def create
    @version = Version.new(version_params)
    respond_to do |format|
      if @version.save
        # 更新已上傳、但未設定 attachable_id 的檔案資料
        Attachment.update_attachable_ids(params[:attachments], @version.id)

        format.html {
          flash[:notice] = I18n.t('helpers.form.create_success', model: Version.model_name.human)
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
      if @version.update(version_params)
        format.html {
          flash[:notice] = I18n.t('helpers.form.update_success', model: Version.model_name.human)
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
    @version.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = I18n.t('helpers.form.destroy_success', model: Version.model_name.human)
        back
      }

      format.js {}
    end
  end





  # 設定連結所屬明細頁籤
  def tabs
    tabs_array = []
    tabs_array << {name: 'versions'}
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

    render partial: "admin/versions/tabs/#{master_show_tab}_tab", locals: { version: @version, master_show_tab: master_show_tab }
  end

  def back
    _navigation = session[:navigation].pop
    redirect_to admin_versions_path if _navigation.nil?
    redirect_to "#{_navigation[:master_show_url] || _navigation['master_show_url']}?master_show_tab=#{_navigation[:master_show_tab] || _navigation['master_show_tab']}&ignore_set_navigation=true" unless _navigation.nil?
  end

  private

  def set_version
    @version = Version.find(params[:id])
    authorize [:admin, @version]
    
  end

  def version_params
    params.require(:version).permit(:item_type, :item_id, :event, :whodunnit, :object, :object_changes)
  end

  def version_row_params(column_values)
    column_values.permit(:item_type, :item_id, :event, :whodunnit, :object, :object_changes)
  end

  # 處理呈現在datatable的資料結構
  def to_datatables(versions)
    versions.map do |version|
      {
        DT_RowId: "#{version.id}",
        id: version.id,
        item_type: version.item_type,
        item_id: version.item_id,
        event: version.event,
        whodunnit: version.whodunnit,
        object: version.object,
        created_at: version.created_at&.strftime('%F %T'),
        object_changes: version.object_changes,
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
    when 'version'
    end
  end

  def class_authorize
    authorize [:admin, Version]
    

    
    
  end
end
