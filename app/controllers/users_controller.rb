# -*- coding: utf-8 -*-
class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy, :change_show_tab, :render_tab_content]
  before_action :set_navigation, only: [:new, :edit, :show, :destroy]
  before_action :class_authorize, only: [:index, :new, :create]

  def index
    session[:navigation] = []
  end

  def datatables

    authorize User, :index?

    respond_to do |format|
      # 設定排序條件
      unless params[:order].blank?
        params[:order].each do |k,v|
          @order_columns ||= []
          @order_columns << "#{params[:columns][ v[:column] ][:data]} #{ v[:dir] }".gsub('_i18n', '')
        end
      end

      @page = (params[:start].to_i/params[:length].to_i) + 1 # 要顯示資料的頁數

      @filters = DatatablesService.new({class_name: "User"}).handle_filters(params)

      @keyword = params[:search][:value] unless params[:search].blank?
      @filters["id_cont".to_sym] = @keyword if @keyword

      class_scope = UserPolicy::Scope.new(current_user, User).resolve
      active_record_query = class_scope
      @q = active_record_query.ransack(@filters)

      @q.sorts = @order_columns.empty? ? ["updated_at desc"] : @order_columns

      @users = @q.result.page(@page).per(params[:length])
      @filtered_count = @q.result.count
      @total_count = active_record_query.count

      format.json {
        render json: {
          recordsTotal: @total_count, # 資料總筆數
          recordsFiltered: @filtered_count, # 過濾後資料筆數
          data: to_datatables(@users) # 整理查詢結果
        }
      }
    end
  end

  def new
    @user ||= User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        # 更新已上傳、但未設定 attachable_id 的檔案資料
        Attachment.update_attachable_ids(params[:attachments], @user.id)

        format.html {
          flash[:notice] = I18n.t('helpers.form.create_success', model: User.model_name.human)
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
      if @user.update(user_params)
        format.html {
          flash[:notice] = I18n.t('helpers.form.update_success', model: User.model_name.human)
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
    @user.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = I18n.t('helpers.form.destroy_success', model: User.model_name.human)
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
          user = User.find_by(id: id)


          authorize user

          user_params = user_row_params(column_values)

          if user&.update(user_params)
            users = User.where(id: id)
            render json: {data: to_datatables(users)}
          end
        }
      end
    end
  end




  # 設定連結所屬明細頁籤
  def tabs
    tabs_array = []
    tabs_array << {name: 'users'}
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

    render partial: "users/tabs/#{master_show_tab}_tab", locals: { user: @user, master_show_tab: master_show_tab }
  end

  def back
    _navigation = session[:navigation].pop
    redirect_to users_path if _navigation.nil?
    redirect_to "#{_navigation[:master_show_url] || _navigation['master_show_url']}?master_show_tab=#{_navigation[:master_show_tab] || _navigation['master_show_tab']}&ignore_set_navigation=true" unless _navigation.nil?
  end

  private

  def set_user
    @user = User.find(params[:id])

    authorize @user
  end

  def user_params
    params.require(:user).permit(:email, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :phone, :self_intro, :name)
  end

  def user_row_params(column_values)
    column_values.permit(:email, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :phone, :self_intro, :name)
  end

  # 處理呈現在datatable的資料結構
  def to_datatables(users)
    users.map do |user|
      {
        DT_RowId: "#{user.id}",
        id: user.id,
        email: user.email,
        encrypted_password: user.encrypted_password,
        reset_password_token: user.reset_password_token,
        reset_password_sent_at: user.reset_password_sent_at&.strftime('%F %T'),
        remember_created_at: user.remember_created_at&.strftime('%F %T'),
        sign_in_count: user.sign_in_count,
        current_sign_in_at: user.current_sign_in_at&.strftime('%F %T'),
        last_sign_in_at: user.last_sign_in_at&.strftime('%F %T'),
        current_sign_in_ip: user.current_sign_in_ip,
        last_sign_in_ip: user.last_sign_in_ip,
        created_at: user.created_at&.strftime('%F %T'),
        updated_at: user.updated_at&.strftime('%F %T'),
        phone: user.phone,
        self_intro: user.self_intro,
        name: user.name,
        deleted_at: user.deleted_at&.strftime('%F %T'),
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
    when 'user'
    end
  end

  def class_authorize

    authorize User



  end
end
