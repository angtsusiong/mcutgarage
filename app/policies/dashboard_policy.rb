class DashboardPolicy < Struct.new(:user, :dashboard)
  def guest?
#    user.has_role? :admin or user.has_role? :examiner or user.has_role? :faculty or user.has_role? :member
    user.nil?
  end

  def sign_in?
    user.has_role? :admin or user.has_role? :examiner or user.has_role? :faculty or user.has_role? :member
  end

  def admin?
    user.has_role? :admin
  end

  def examiner?
    user.has_role? :examiner
  end

  def faculty?
    user.has_role? :faculty
  end

  def member?
    user.has_role? :member
  end

end
