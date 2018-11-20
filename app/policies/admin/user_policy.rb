class Admin::UserPolicy < AdminPolicy
  def index?
    common_permission
  end

  def new?
    common_permission
  end

  def create?
    common_permission
  end

  def show?
    common_permission
  end

  def edit?
    common_permission
  end

  def update?
    common_permission
  end

  def destroy?
    common_permission
  end

  def update_row?
    common_permission
  end

  def change_show_tab?
    common_permission
  end

  def render_tab_content?
    common_permission
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def common_permission
    user.has_role? :admin or user.has_role? :examiner or user.has_role? :faculty
  end

  def admin_permission
    user.has_role? :admin
  end

  def examiner_permission
    user.has_role? :examiner
  end

  def faculty_permission
    user.has_role? :faculty
  end

  def member_permission
    user.has_role? :member
  end
end
